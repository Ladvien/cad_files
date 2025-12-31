// =============================================================================
// PRIMITIVES LIBRARY
// Common geometric primitives for OpenSCAD projects
// =============================================================================

// Centered rectangle (2D)
module rect(w, h) {
    square([w, h], center = true);
}

// Centered cube (3D)
module box(x, y, z) {
    cube([x, y, z], center = true);
}
