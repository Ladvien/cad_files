# OpenSCAD Best Practices

## Resolution
- `$fn = 32-64` for preview, `$fn = 100+` only for final export
- Higher values slow rendering with no visual benefit

## 2D First
- Prefer 2D primitives + `linear_extrude()` over direct 3D operations
- `hull()` on 2D shapes then extrude is faster than `hull()` on 3D cylinders

## Offset for Fillets
```openscad
// Round inside corners (fillet)
module fillet(r) {
    offset(r = -r) offset(delta = r) children();
}

// Round outside corners (round)
module round(r) {
    offset(r = r) offset(delta = -r) children();
}
```

## Subtractive vs Additive
- **Subtractive** (difference from solid) is often simpler and more reliable
- **Additive** (union of pieces) can leave gaps if geometry doesn't overlap

## Modular Design
- Create small primitive modules for reusable shapes
- Compose complex shapes from primitives
- Keep dimensions as parameters at top of file

## Debugging
- `!` before a shape shows only that part
- `#` makes a shape transparent red (shows what's being subtracted)
- `%` makes a shape transparent gray (ghost)
- `*` disables a shape entirely

## Rendering
- **F5** - Fast preview (use 95% of the time)
- **F6** - Full render (required before STL export)
- Enable **Design → Automatic Reload** for live updates

## Common Patterns
```openscad
// Centered rectangle
module rect(w, h) {
    square([w, h], center = true);
}

// T-slot cutout (for aluminum extrusion)
module t_slot(opening, depth, inner_width) {
    union() {
        // Outer opening
        translate([0, -depth/2])
            square([opening, depth], center = true);
        // Inner cavity
        translate([0, -depth + (depth - 1.5)/2])
            square([inner_width, depth - 1.5], center = true);
    }
}
```

## Key Dimensions: 2020 Aluminum Extrusion
- Overall: 20 × 20 mm
- Slot opening: 6.2 mm
- Slot depth: 6.1 mm
- Center hole: φ5 mm
- Wall thickness: 1.5 mm
