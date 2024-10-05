#include "sim.h"

void app() {
    int grid[SIM_Y_SIZE * SIM_X_SIZE] = {0};

    // ----- Initialization

    for (int y = 0; y < SIM_Y_SIZE; ++y)
        for (int x = 0; x < SIM_X_SIZE; ++x)
            if (simRand() % 5 == 0)
                grid[y * SIM_X_SIZE + x] = 1;
            else
                grid[y * SIM_X_SIZE + x] = 0;

    // ----- Evolution

    for (int step = 0; step < 1000; ++step) {
        for (int y = 0; y < SIM_Y_SIZE; ++y) {
            for (int x = 0; x < SIM_X_SIZE; ++x) {
                int live_neighbours = 0;

                // count the number of living neighbours

                if (y > 0) {
                    live_neighbours += grid[(y - 1) * SIM_X_SIZE + x] & 1;
                    if (x > 0)
                        live_neighbours += grid[(y - 1) * SIM_X_SIZE + x - 1] & 1;
                    if (x + 1 < SIM_X_SIZE)
                        live_neighbours += grid[(y - 1) * SIM_X_SIZE + x + 1] & 1;
                }
                if (y + 1 < SIM_Y_SIZE) {
                    live_neighbours += grid[(y + 1) * SIM_X_SIZE + x] & 1;
                    if (x > 0)
                        live_neighbours += grid[(y + 1) * SIM_X_SIZE + x - 1] & 1;
                    if (x + 1 < SIM_X_SIZE)
                        live_neighbours += grid[(y + 1) * SIM_X_SIZE + x + 1] & 1;
                }
                if (x > 0)
                    live_neighbours += grid[y * SIM_X_SIZE + x - 1] & 1;
                if (x + 1 < SIM_X_SIZE)
                    live_neighbours += grid[y * SIM_X_SIZE + x + 1] & 1;

                // make a transition

                if (grid[y * SIM_X_SIZE + x]) {
                    if (live_neighbours == 2 || live_neighbours == 3)
                        grid[y * SIM_X_SIZE + x] |= 2;
                } else {
                    if (live_neighbours == 3)
                        grid[y * SIM_X_SIZE + x] |= 2;
                }

                // draw a pixel

                simPutPixel(x, y, 0xFF000000 + 0xFFFFFF * (grid[y * SIM_X_SIZE + x] >> 1));
            }
        }

        // transfer the grid to a new state

        for (int y = 0; y < SIM_Y_SIZE; ++y)
            for (int x = 0; x < SIM_X_SIZE; ++x)
                grid[y * SIM_X_SIZE + x] >>= 1;

        // flush generated frame

        simFlush();
    }
}