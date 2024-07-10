struct Context<'a> {
    matrix: &'a mut Vec<Vec<u32>>,
    row: &'a mut usize,
    col: &'a mut usize,
    val: &'a mut u32,
}

macro_rules! fill_spiral {
    ($ctx:expr, $cond:expr, $focus:expr, $unvisited:expr, $dir:tt) => {
        while $cond($focus) && $unvisited == 0 {
            $focus $dir 1;
            $ctx.matrix[*$ctx.row][*$ctx.col] = *$ctx.val;
            *$ctx.val += 1;
        }
    };
}

// general approach copied from
// https://exercism.org/tracks/rust/exercises/spiral-matrix/solutions/danieljl
pub fn spiral_matrix(size: usize) -> Vec<Vec<u32>> {
    let mut matrix = vec![vec![0; size]; size];
    if size == 0 {
        return matrix;
    }
    matrix[0][0] = 1;

    let mut val: u32 = 2;
    let mut row: usize = 0;
    let mut col: usize = 0;

    let ctx = Context {
        matrix: &mut matrix,
        row: &mut row,
        col: &mut col,
        val: &mut val,
    };

    let small_enough = |i| i <= size - 2;
    let big_enough = |i| i >= 1;

    while *ctx.val <= (size * size) as u32 {
        fill_spiral!(
            ctx,
            small_enough,
            *ctx.col,
            ctx.matrix[*ctx.row][*ctx.col + 1],
            +=
        );

        fill_spiral!(
            ctx,
            small_enough,
            *ctx.row,
            ctx.matrix[*ctx.row + 1][*ctx.col],
            +=
        );

        fill_spiral!(
            ctx,
            big_enough,
            *ctx.col,
            ctx.matrix[*ctx.row][*ctx.col - 1],
            -=
        );

        fill_spiral!(
            ctx,
            big_enough,
            *ctx.row,
            ctx.matrix[*ctx.row - 1][*ctx.col],
            -=
        );
    }

    ctx.matrix.clone()
}
