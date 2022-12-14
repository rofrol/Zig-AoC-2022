## 2022-11-14T03:58:00

I was getting this error:

```
% zig build test
./src/day01.zig:49:69: error: expected type 'std.meta.struct:1134:19', found 'day01.struct:49:69'
    var result = try util2.benchmark(std.testing.allocator, solve, .{@embedFile("data/day01.txt")}, .{});
                                                                    ^
/Users/rfrolow/.local/zig/ver/zig-macos-aarch64-0.11.0-dev.116+41b7e40d7/lib/std/meta.zig:1134:19: note: std.meta.struct:1134:19 declared here
    return @Type(.{
                  ^
./src/day01.zig:49:69: note: day01.struct:49:69 declared here
    var result = try util2.benchmark(std.testing.allocator, solve, .{@embedFile("data/day01.txt")}, .{});
                                                                    ^
error: test...
error: The following command exited with error code 1:
/Users/rfrolow/.local/zig/ver/zig-macos-aarch64-0.11.0-dev.116+41b7e40d7/zig test -fstage1 /Users/rfrolow/personal_projects/zig/Zig-AoC-2022/src/test_all.zig --cache-dir /Users/rfrolow/personal_projects/zig/Zig-AoC-2022/zig-cache --global-cache-dir /Users/rfrolow/.cache/zig --name test --enable-cache
error: the following build command failed with exit code 1:
/Users/rfrolow/personal_projects/zig/Zig-AoC-2022/zig-cache/o/2c6293ac8a478f45205adbaca924f735/build /Users/rfrolow/.local/zig/ver/zig-macos-aarch64-0.11.0-dev.116+41b7e40d7/zig /Users/rfrolow/personal_projects/zig/Zig-AoC-2022 /Users/rfrolow/personal_projects/zig/Zig-AoC-2022/zig-cache /Users/rfrolow/.cache/zig test
```

After switching to version without my changes, running `zig build test` and apply my changes again, `zig build test` worked.

## 2022-11-14T19:02:00

switch on type tuple or struct impossible.

> Zig only supports switch statements on things you can check equality of. `if(p == Point{.x = 11, .y = 12, .z = 13}) {}` isn't a thing you can do. You have to use `std.meta.eql(p, Point{.x = 11, .y = 12, .z = 13})` https://www.reddit.com/r/Zig/comments/it8fga/comment/g5j1abb/

> Llvm generates offset tables for switch statements and these depend on the switched type being an integer. This is also why you can't switch on a string. https://www.reddit.com/r/Zig/comments/it8fga/comment/g5d83ww/

> I often find myself rewriting the pattern matches as multiple sequential ifs https://www.reddit.com/r/Zig/comments/it8fga/comment/g5futls/

## There is no &&, use and

https://ziglang.org/documentation/master/#Operators
