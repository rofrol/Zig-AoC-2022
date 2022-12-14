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

fn solve(data: []const u8) !u32 {
    var sum: u32 = 0;
    var readIter = std.mem.split(u8, data, "\n");
    while (readIter.next()) |line| {
        sum += if (std.mem.eql(u8, line, "A X")) 1 + 3 else if (std.mem.eql(u8, line, "A Y")) 2 + 6 else if (std.mem.eql(u8, line, "A Z")) 3 + 0 else if (std.mem.eql(u8, line, "B X")) 1 + 0 else if (std.mem.eql(u8, line, "B Y")) 2 + 3 else if (std.mem.eql(u8, line, "B Z")) 3 + 6 else if (std.mem.eql(u8, line, "C X")) 1 + 6 else if (std.mem.eql(u8, line, "C Y")) 2 + 0 else if (std.mem.eql(u8, line, "C Z")) 3 + 3 else 0;
        // std.debug.print("{s}\n", .{line});
        // std.debug.print("{}\n", .{sum});
    }
    return sum;
}

fn solve2(data: []const u8) !u32 {
    var sum: u32 = 0;
    var readIter = std.mem.split(u8, data, "\n");
    while (readIter.next()) |line| {
        sum += if (std.mem.eql(u8, line, "A X")) 3 + 0 else if (std.mem.eql(u8, line, "A Y")) 1 + 3 else if (std.mem.eql(u8, line, "A Z")) 2 + 6 else if (std.mem.eql(u8, line, "B X")) 1 + 0 else if (std.mem.eql(u8, line, "B Y")) 2 + 3 else if (std.mem.eql(u8, line, "B Z")) 3 + 6 else if (std.mem.eql(u8, line, "C X")) 2 + 0 else if (std.mem.eql(u8, line, "C Y")) 3 + 3 else if (std.mem.eql(u8, line, "C Z")) 1 + 6 else 0;
        // std.debug.print("{s}\n", .{line});
        // std.debug.print("{}\n", .{sum});
    }
    return sum;
}

const valueMap = std.ComptimeStringMap(u32, .{ .{ "A X", 1 + 3 }, .{ "A Y", 2 + 6 }, .{ "A Z", 3 + 0 }, .{ "B X", 1 + 0 }, .{ "B Y", 2 + 3 }, .{ "B Z", 3 + 6 }, .{ "C X", 1 + 6 }, .{ "C Y", 2 + 0 }, .{ "C Z", 3 + 3 } });

const outcomeMap = std.ComptimeStringMap(u32, .{ .{ "A X", 3 + 0 }, .{ "A Y", 1 + 3 }, .{ "A Z", 2 + 6 }, .{ "B X", 1 + 0 }, .{ "B Y", 2 + 3 }, .{ "B Z", 3 + 6 }, .{ "C X", 2 + 0 }, .{ "C Y", 3 + 3 }, .{ "C Z", 1 + 6 } });

fn solve1_2(data: []const u8) !u32 {
    var sum: u32 = 0;
    var readIter = std.mem.split(u8, data, "\n");
    while (readIter.next()) |line| {
        sum += valueMap.get(line).?;
    }
    return sum;
}

fn solve2_2(data: []const u8) !u32 {
    var sum: u32 = 0;
    var readIter = std.mem.split(u8, data, "\n");
    while (readIter.next()) |line| {
        sum += outcomeMap.get(line).?;
    }
    return sum;
}

test "test-input" {
    const sum1 = try solve(@embedFile("data/day02ex.txt"));
    try util2.expectEq(15, sum1);

    const sum2 = try solve(@embedFile("data/day02.txt"));
    try util2.expectEq(11063, sum2);

    var result = try util2.benchmark(std.testing.allocator, solve, .{@embedFile("data/day02.txt")}, .{});
    defer result.deinit();
    result.printSummary();

    const sum3 = try solve2(@embedFile("data/day02ex.txt"));
    try util2.expectEq(12, sum3);

    const sum4 = try solve2(@embedFile("data/day02.txt"));
    try util2.expectEq(10349, sum4);

    var result2 = try util2.benchmark(std.testing.allocator, solve2, .{@embedFile("data/day02.txt")}, .{});
    defer result2.deinit();
    result2.printSummary();
}

test "test-input 2" {
    const sum1 = try solve1_2(@embedFile("data/day02ex.txt"));
    try util2.expectEq(15, sum1);

    const sum2 = try solve1_2(@embedFile("data/day02.txt"));
    try util2.expectEq(11063, sum2);

    var result = try util2.benchmark(std.testing.allocator, solve1_2, .{@embedFile("data/day02.txt")}, .{});
    defer result.deinit();
    result.printSummary();

    const sum3 = try solve2_2(@embedFile("data/day02ex.txt"));
    try util2.expectEq(12, sum3);

    const sum4 = try solve2_2(@embedFile("data/day02.txt"));
    try util2.expectEq(10349, sum4);

    var result2 = try util2.benchmark(std.testing.allocator, solve2_2, .{@embedFile("data/day02.txt")}, .{});
    defer result2.deinit();
    result2.printSummary();
}
