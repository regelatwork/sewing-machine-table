module inner() {
  import("sewing-table-inner.dxf");
}

module side() {
  import("sewing-table-side.dxf");
}

module wheel() {
  import("sewing-table-wheel.dxf");
}

module pedal() {
  import("sewing-table-pedal.dxf");
}

linear_extrude(height = 1.2)
side();