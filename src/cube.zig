const point = @import("point.zig");
const Point = point.Point;

pub const verticies = [_]Point{
    Point{ .x = 0.25, .y = 0.25, .z = 0.25 },
    Point{ .x = -0.25, .y = 0.25, .z = 0.25 },
    Point{ .x = -0.25, .y = -0.25, .z = 0.25 },
    Point{ .x = 0.25, .y = -0.25, .z = 0.25 },

    Point{ .x = 0.25, .y = 0.25, .z = -0.25 },
    Point{ .x = -0.25, .y = 0.25, .z = -0.25 },
    Point{ .x = -0.25, .y = -0.25, .z = -0.25 },
    Point{ .x = 0.25, .y = -0.25, .z = -0.25 },
};

pub const faces = [_][]const i32{
    &[_]i32{ 0, 1, 2, 3 },
    &[_]i32{ 4, 5, 6, 7 },
    &[_]i32{ 0, 4 },
    &[_]i32{ 1, 5 },
    &[_]i32{ 2, 6 },
    &[_]i32{ 3, 7 },
};
