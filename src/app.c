#include "sim.h"

void app() {
    int grid[(SIM_Y_SIZE + 2) * (SIM_X_SIZE + 2)] = {0};
    int new_grid[(SIM_Y_SIZE + 2) * (SIM_X_SIZE + 2)] = {0};

    const int row_size = SIM_X_SIZE + 2;
    const int grid_size = (SIM_Y_SIZE + 2) * (SIM_X_SIZE + 2);

    // ----- Initialization

    for (int y = 1; y <= SIM_Y_SIZE; ++y)
        for (int x = 1; x <= SIM_X_SIZE; ++x)
            if (simRand() % 5 == 0)
                grid[y * row_size + x] = 1;
            else
                grid[y * row_size + x] = 0;

    // ----- Evolution

    for (int generation = 0; generation < 1000; ++generation) {
        for (int i = row_size; i < grid_size - row_size; ++i) {
            const int x = i % row_size;
            const int y = i / row_size;

            if (x == 0 || x == row_size - 1)
                continue;

            int* cell = &grid[i];

            // draw a pixel

            simPutPixel(x - 1, y - 1, 0xFF000000 + 0xFFFFFF * (*cell));

            // count the number of living neighbours

            int live_neighbours = 0;

            int* ptr_1 = cell - row_size;
            live_neighbours += *(ptr_1 - 1);
            live_neighbours += *ptr_1;
            live_neighbours += *(ptr_1 + 1);

            live_neighbours += *(cell - 1);
            live_neighbours += *(cell + 1);

            int* ptr_2 = cell + row_size;
            live_neighbours += *(ptr_2 - 1);
            live_neighbours += *ptr_2;
            live_neighbours += *(ptr_2 + 1);

            // make a transition

            int* new_cell = &new_grid[i];

            if (live_neighbours == 3 || (*cell != 0 && live_neighbours == 2))
                *new_cell = 1;
            else
                *new_cell = 0;
        }

        // transfer the grid to a new state

        for (int i = 0; i < grid_size; ++i)
            grid[i] = new_grid[i];

        // flush generated frame

        simFlush();
    }
}