Surface.prototype.sphere = (x = 0, y = 0, z = 0, radius = 8, step = 6) => {
    const points = [];
    const edges = [];
    const polygones = [];

    function createPointFromSpherical(radius, zenith, azimuth) {
        let x = radius * Math.sin(zenith) * Math.cos(azimuth);
        let y = radius * Math.sin(zenith) * Math.sin(azimuth);
        let z = radius * Math.cos(zenith);
        return new Point(x, y, z);
    }

    function createPoints(x, y, z, radius, step) {
        const zenithStep = Math.PI / step;
        const azimuthStep = 2 * Math.PI / step;
        points.push(createPointFromSpherical(radius, 0, 0).add(x, y, z));
        for (let j = 0; j < step; ++j) {
            let azimuth = azimuthStep * j;
            for (let i = 1; i < step; ++i) {
                let zenith = zenithStep * i;
                const point = createPointFromSpherical(radius, zenith, azimuth).add(x, y, z);
                points.push(point);
            }
        }
        points.push(createPointFromSpherical(radius, Math.PI, 0).add(x, y, z));
    }

    function createPolygons(step) {
        const quads = [];
        for (let i = 0; i < step; ++i) {
            quads.push([i + 1, i + 2, step + i, step + i + 1]);
        }
    }

    createPoints(x, y, z, radius, step);
    return new Subject(points, edges, polygones);
}