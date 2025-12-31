// =============================================================================
// 2020 ALUMINUM EXTRUSION LIBRARY
// Standard 20x20mm T-slot aluminum extrusion profile
// =============================================================================

use <primitives.scad>

// 2D cross-section profile
module 2020_profile() {
    // Manufacturer dimensions
    size = 20;           // Overall size
    slot_open = 6.2;     // Slot opening width
    slot_depth = 6.1;    // Slot depth from outer edge
    hole_d = 5;          // Center hole diameter
    wall = 1.5;          // Wall/bar thickness
    inner_slot = 11;     // Inner T-slot width (for T-nut)

    // Derived
    half = size / 2;     // 10

    union() {
        // MAIN PROFILE (subtractive)
        difference() {
            rect(size, size);

            // Center hole
            circle(d = hole_d);

            // T-slot cavities on all 4 sides
            for (rot = [0, 90, 180, 270]) {
                rotate([0, 0, rot]) {
                    // Outer slot opening
                    translate([0, half - wall/2])
                        rect(slot_open, wall + 0.01);

                    // Inner cavity
                    translate([0, half - slot_depth/2 - wall/2])
                        rect(inner_slot, slot_depth - wall);
                }
            }
        }

        // DIAGONAL BARS (added last, won't be cut)
        // Extend from center (~radius 3) to corner center (~radius 10)
        for (rot = [45, 135, 225, 315]) {
            rotate([0, 0, rot])
                translate([0, 6.5])
                    rect(wall, 7);
        }
    }
}

// 3D extrusion with specified length
module 2020_extrusion(length = 100) {
    color("silver")
    linear_extrude(height = length)
        2020_profile();
}
