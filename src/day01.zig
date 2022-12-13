const std = @import("std");
const Allocator = std.mem.Allocator;
const List = std.ArrayList;
const Map = std.AutoHashMap;
const StrMap = std.StringHashMap;
const BitSet = std.DynamicBitSet;

const util = @import("util.zig");
const gpa = util.gpa;

const util2 = @import("util2.zig");

// const data = @embedFile("data/day01.txt");

pub fn main() !void {
    print("Hello\n", .{});
}

fn solve(data: []const u8) ![3]u32 {
    var maximal: [3]u32 = .{ 0, 0, 0 };
    var temp: u32 = 0;

    var lines = std.ArrayList([]const u8).init(gpa);
    defer lines.deinit();
    var readIter = std.mem.split(u8, data, "\n");
    while (readIter.next()) |line| {
        if (line.len != 0) {
            temp += try std.fmt.parseInt(u32, line, 10);
        } else {
            if (temp > maximal[0]) {
                maximal[0] = temp;
                temp = 0;
            }
        }

        try lines.append(line);
        // print("{s}\n", .{line});
    }
    // print("{d}\n", .{maximal[0]});
    return maximal;
}

test "test-input" {
    const maximum = try solve(@embedFile("data/day01test.txt"));
    // const total = @reduce(.Add, @as(@Vector(3, u32), maximum));
    try std.testing.expectEqual(maximum[0], 24000);
    // try std.testing.expectEqual(total, 45000);

    var result = try util2.benchmark(std.testing.allocator, solve, .{@embedFile("data/day01.txt")}, .{});
    defer result.deinit();
    result.printSummary();
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
