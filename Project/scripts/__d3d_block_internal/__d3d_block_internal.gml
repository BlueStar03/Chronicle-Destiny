// Feather disable all
function __d3d_block_internal(vb, x1, y1, z1, x2, y2, z2, hrepeat, vrepeat, zrepeat, c, a) {
    static vertex = Drago3D_Internals.Vertex;
    
    // -- FACE 1: FRONT (Normal -Z) -- 
    // Uses H (x) and V (y)
    vertex(vb, x1, y1, z1, 0, 0, -1, 0, 0, c, a);
    vertex(vb, x1, y2, z1, 0, 0, -1, 0, vrepeat, c, a);
    vertex(vb, x2, y2, z1, 0, 0, -1, hrepeat, vrepeat, c, a);
        
    vertex(vb, x2, y2, z1, 0, 0, -1, hrepeat, vrepeat, c, a);
    vertex(vb, x2, y1, z1, 0, 0, -1, hrepeat, 0, c, a);
    vertex(vb, x1, y1, z1, 0, 0, -1, 0, 0, c, a);
        
    // -- FACE 2: BACK (Normal +Z) --
    // Uses H (x) and V (y)
    vertex(vb, x1, y1, z2, 0, 0, 1, 0, 0, c, a);
    vertex(vb, x2, y1, z2, 0, 0, 1, hrepeat, 0, c, a);
    vertex(vb, x2, y2, z2, 0, 0, 1, hrepeat, vrepeat, c, a);
        
    vertex(vb, x2, y2, z2, 0, 0, 1, hrepeat, vrepeat, c, a);
    vertex(vb, x1, y2, z2, 0, 0, 1, 0, vrepeat, c, a);
    vertex(vb, x1, y1, z2, 0, 0, 1, 0, 0, c, a);
        
    // -- FACE 3: TOP (Normal +Y) --
    // Uses H (x) and Z (z)
    vertex(vb, x1, y2, z1, 0, 1, 0, 0, 0, c, a);
    vertex(vb, x1, y2, z2, 0, 1, 0, 0, zrepeat, c, a);
    vertex(vb, x2, y2, z2, 0, 1, 0, hrepeat, zrepeat, c, a);
        
    vertex(vb, x2, y2, z2, 0, 1, 0, hrepeat, zrepeat, c, a);
    vertex(vb, x2, y2, z1, 0, 1, 0, hrepeat, 0, c, a);
    vertex(vb, x1, y2, z1, 0, 1, 0, 0, 0, c, a);
        
    // -- FACE 4: RIGHT (Normal +X) --
    // Uses Z (z) and V (y)
    vertex(vb, x2, y2, z1, 1, 0, 0, 0, 0, c, a);
    vertex(vb, x2, y2, z2, 1, 0, 0, zrepeat, 0, c, a);
    vertex(vb, x2, y1, z2, 1, 0, 0, zrepeat, vrepeat, c, a);
        
    vertex(vb, x2, y1, z2, 1, 0, 0, zrepeat, vrepeat, c, a);
    vertex(vb, x2, y1, z1, 1, 0, 0, 0, vrepeat, c, a);
    vertex(vb, x2, y2, z1, 1, 0, 0, 0, 0, c, a);
        
    // -- FACE 5: BOTTOM (Normal -Y) --
    // Uses H (x) and Z (z)
    vertex(vb, x2, y1, z1, 0, -1, 0, 0, 0, c, a);
    vertex(vb, x2, y1, z2, 0, -1, 0, 0, zrepeat, c, a);
    vertex(vb, x1, y1, z2, 0, -1, 0, hrepeat, zrepeat, c, a);
        
    vertex(vb, x1, y1, z2, 0, -1, 0, hrepeat, zrepeat, c, a);
    vertex(vb, x1, y1, z1, 0, -1, 0, hrepeat, 0, c, a);
    vertex(vb, x2, y1, z1, 0, -1, 0, 0, 0, c, a);
        
    // -- FACE 6: LEFT (Normal -X) --
    // Uses Z (z) and V (y)
    vertex(vb, x1, y1, z1, -1, 0, 0, 0, vrepeat, c, a);
    vertex(vb, x1, y1, z2, -1, 0, 0, zrepeat, vrepeat, c, a);
    vertex(vb, x1, y2, z2, -1, 0, 0, zrepeat, 0, c, a);
        
    vertex(vb, x1, y2, z2, -1, 0, 0, zrepeat, 0, c, a);
    vertex(vb, x1, y2, z1, -1, 0, 0, 0, 0, c, a);
    vertex(vb, x1, y1, z1, -1, 0, 0, 0, vrepeat, c, a);
}
/*
// Feather disable all
function __d3d_block_internal(vb, x1, y1, z1, x2, y2, z2, hrepeat, vrepeat, c, a) {
    static vertex = Drago3D_Internals.Vertex;
    
    vertex(vb, x1, y1, z1, 0, 0, -1, 0, 0, c, a);
    vertex(vb, x1, y2, z1, 0, 0, -1, 0, vrepeat, c, a);
    vertex(vb, x2, y2, z1, 0, 0, -1, hrepeat, vrepeat, c, a);
        
    vertex(vb, x2, y2, z1, 0, 0, -1, hrepeat, vrepeat, c, a);
    vertex(vb, x2, y1, z1, 0, 0, -1, hrepeat, 0, c, a);
    vertex(vb, x1, y1, z1, 0, 0, -1, 0, 0, c, a);
        
    vertex(vb, x1, y1, z2, 0, 0, 1, 0, 0, c, a);
    vertex(vb, x2, y1, z2, 0, 0, 1, hrepeat, 0, c, a);
    vertex(vb, x2, y2, z2, 0, 0, 1, hrepeat, vrepeat, c, a);
        
    vertex(vb, x2, y2, z2, 0, 0, 1, hrepeat, vrepeat, c, a);
    vertex(vb, x1, y2, z2, 0, 0, 1, 0, vrepeat, c, a);
    vertex(vb, x1, y1, z2, 0, 0, 1, 0, 0, c, a);
        
    vertex(vb, x1, y2, z1, 0, 1, 0, 0, 0, c, a);
    vertex(vb, x1, y2, z2, 0, 1, 0, 0, vrepeat, c, a);
    vertex(vb, x2, y2, z2, 0, 1, 0, hrepeat, vrepeat, c, a);
        
    vertex(vb, x2, y2, z2, 0, 1, 0, hrepeat, vrepeat, c, a);
    vertex(vb, x2, y2, z1, 0, 1, 0, hrepeat, 0, c, a);
    vertex(vb, x1, y2, z1, 0, 1, 0, 0, 0, c, a);
        
    vertex(vb, x2, y2, z1, 1, 0, 0, 0, 0, c, a);
    vertex(vb, x2, y2, z2, 1, 0, 0, 0, vrepeat, c, a);
    vertex(vb, x2, y1, z2, 1, 0, 0, hrepeat, vrepeat, c, a);
        
    vertex(vb, x2, y1, z2, 1, 0, 0, hrepeat, vrepeat, c, a);
    vertex(vb, x2, y1, z1, 1, 0, 0, hrepeat, 0, c, a);
    vertex(vb, x2, y2, z1, 1, 0, 0, 0, 0, c, a);
        
    vertex(vb, x2, y1, z1, 0, -1, 0, 0, 0, c, a);
    vertex(vb, x2, y1, z2, 0, -1, 0, 0, vrepeat, c, a);
    vertex(vb, x1, y1, z2, 0, -1, 0, hrepeat, vrepeat, c, a);
        
    vertex(vb, x1, y1, z2, 0, -1, 0, hrepeat, vrepeat, c, a);
    vertex(vb, x1, y1, z1, 0, -1, 0, hrepeat, 0, c, a);
    vertex(vb, x2, y1, z1, 0, -1, 0, 0, 0, c, a);
        
    vertex(vb, x1, y1, z1, -1, 0, 0, 0, 0, c, a);
    vertex(vb, x1, y1, z2, -1, 0, 0, 0, vrepeat, c, a);
    vertex(vb, x1, y2, z2, -1, 0, 0, hrepeat, vrepeat, c, a);
        
    vertex(vb, x1, y2, z2, -1, 0, 0, hrepeat, vrepeat, c, a);
    vertex(vb, x1, y2, z1, -1, 0, 0, hrepeat, 0, c, a);
    vertex(vb, x1, y1, z1, -1, 0, 0, 0, 0, c, a);
}
 */ 