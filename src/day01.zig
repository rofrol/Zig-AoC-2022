const std = @import("std");
const Allocator = std.mem.Allocator;
const List = std.ArrayList;
const Map = std.AutoHashMap;
const StrMap = std.StringHashMap;
const BitSet = std.DynamicBitSet;

const util = @import("util.zig");
const util2 = @import("util2.zig");
const gpa = util.gpa;

pub fn main() !void {}

fn solve(input: []const u8) ![2]u32 {
    var maximum: [4]u32 = .{ 0, 0, 0, 0 };

    var readIter = std.mem.split(u8, input, "\n");
    while (readIter.next()) |line| {
        if (line.len != 0) {
            maximum[3] += try std.fmt.parseInt(u32, line, 10);
        } else {
            std.sort.sort(u32, &maximum, {}, comptime std.sort.desc(u32));
            maximum[3] = 0;
        }
        // print("\n{any}", .{maximum});
    }

    std.sort.sort(u32, &maximum, {}, comptime std.sort.desc(u32));
    // print("\nresult: {any}", .{maximum});
    return .{ maximum[0], maximum[0] + maximum[1] + maximum[2] };
}

test "test-input" {
    const maximum = try solve(@embedFile("data/day01test.txt"));
    try util2.expectEq(24000, maximum[0]);
    try util2.expectEq(45000, maximum[1]);

    const maximum2 = try solve(@embedFile("data/day01.txt"));
    try std.testing.expectEqual(maximum2[0], 71780);
    try std.testing.expectEqual(maximum2[1], 212489);
}

// Useful stdlib functions
const tokenize = std.mem.tokenize;
const split = std.mem.split;
const indexOf = std.mem.indexOfScalar;
const indexOfAny = std.mem.indexOfAny;
const indexOfStr = std.mem.indexOfPosLinear;
const lastIndexOf = std.mem.lastIndexOfScalar;
const lastIndexOfAny = std.mem.lastIndexOfAny;
const lastIndexOfStr = std.mem.lastIndexOfLinear;
const trim = std.mem.trim;
const sliceMin = std.mem.min;
const sliceMax = std.mem.max;

const parseInt = std.fmt.parseInt;
const parseFloat = std.fmt.parseFloat;

const min = std.math.min;
const min3 = std.math.min3;
const max = std.math.max;
const max3 = std.math.max3;

const print = std.debug.print;
const assert = std.debug.assert;

const sort = std.sort.sort;
const asc = std.sort.asc;
const desc = std.sort.desc;

// Generated from template/template.zig.
// Run `zig build generate` to update.
// Only unmodified days will be updated.
