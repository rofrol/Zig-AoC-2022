const std = @import("std");
const util = @import("util.zig");
const util2 = @import("util2.zig");

const gpa = util.gpa;

const data = @embedFile("data/day01.txt");

pub fn main() !void {
    std.debug.print("{any}", .{try solve(data)});
}

fn solve(input: []const u8) ![2]u32 {
    var maximum: [4]u32 = .{ 0, 0, 0, 0 };

    var readIter = std.mem.split(u8, input, "\n");
    while (readIter.next()) |line| {
        if (line.len != 0) {
            maximum[3] += try std.fmt.parseUnsigned(u32, line, 10);
        } else {
            std.sort.sort(u32, &maximum, {}, comptime std.sort.desc(u32));
            maximum[3] = 0;
        }
    }

    std.sort.sort(u32, &maximum, {}, comptime std.sort.desc(u32));
    return .{ maximum[0], maximum[0] + maximum[1] + maximum[2] };
}

test "test-input" {
    const maximum = try solve(@embedFile("data/day01test.txt"));
    try util2.expectEq(24000, maximum[0]);
    try util2.expectEq(45000, maximum[1]);

    const maximum2 = try solve(@embedFile("data/day01.txt"));
    try std.testing.expectEqual(maximum2[0], 71780);
    try std.testing.expectEqual(maximum2[1], 212489);

    var result = try util2.benchmark(std.testing.allocator, solve, .{@embedFile("data/day01.txt")}, .{});
    defer result.deinit();
    result.printSummary();
}
