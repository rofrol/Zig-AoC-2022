const std = @import("std");
pub const Map = std.AutoHashMap;

pub const BenchmarkOptions = struct {
    trials: u32 = 10_000,
    warmup: u32 = 100,
};

pub const BenchmarkResult = struct {
    const Self = @This();

    alloc: std.mem.Allocator,
    opts: BenchmarkOptions,
    mean: u64,

    pub fn deinit(_: *Self) void {}

    pub fn printSummary(self: *const Self) void {
        const print = std.debug.print;
        print(
            \\ Benchmark summary for {d} trials:
            \\ Mean: {s}
            \\
        , .{
            self.opts.trials,
            std.fmt.fmtDuration(self.mean),
        });
    }
};

fn invoke(comptime func: anytype, args: std.meta.ArgsTuple(@TypeOf(func))) void {
    const ReturnType = @typeInfo(@TypeOf(func)).Fn.return_type.?;
    switch (@typeInfo(ReturnType)) {
        .ErrorUnion => {
            _ = @call(.{ .modifier = .never_inline }, func, args) catch {
                // std.debug.panic("Benchmarked function returned error {s}", .{err});
            };
        },
        else => _ = @call(.{ .modifier = .never_inline }, func, args),
    }
}

pub fn benchmark(
    alloc: std.mem.Allocator,
    comptime func: anytype,
    args: std.meta.ArgsTuple(@TypeOf(func)),
    opts: BenchmarkOptions,
) !BenchmarkResult {
    var count: usize = 0;
    while (count < opts.warmup) : (count += 1) {
        invoke(func, args);
    }
    var timer = try std.time.Timer.start();
    while (count < opts.trials) : (count += 1) {
        invoke(func, args);
    }
    const mean = @divFloor(timer.lap(), opts.trials);
    return .{ .alloc = alloc, .opts = opts, .mean = mean };
}

// https://github.com/ziglang/zig/issues/4437#issuecomment-683309291
// https://github.com/ziglang/zig/issues/4437#issuecomment-585408987
// https://github.com/zigimg/zigimg/blob/e57148bf6c6df395ef308e559ec833639940220c/tests/helpers.zig#LL14C5-L16C2
pub fn expectEq(expected: anytype, actual: anytype) !void {
    try std.testing.expectEqual(@as(@TypeOf(actual), expected), actual);
}
