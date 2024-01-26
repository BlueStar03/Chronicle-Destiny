function Interval(val_min, val_max) constructor {
	self.val_min = val_min;
	self.val_max = val_max;
}

function sat_overlap_axis(shape1, shape2, axis) {
	var a = shape1.get_interval(axis);
	var b = shape2.get_interval(axis);
	return (b.val_min <= a.val_max) && (a.val_min <= b.val_max);
}