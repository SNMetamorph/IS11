Surface.prototype.sphere = (x = 0, y = 0, z = 0, radius = 4, step = 12) => {
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

    function createMainPartPolys(step, quads) {
        for (let i = 0; i < step - 1; ++i) {
            for (let j = 0; j < step - 2; ++j) {
                const index = j + i * (step - 1);
                quads.push([index + 1, index + 2, step + index, step + index + 1]);
            }
        }
    }

    function createVertJointPolys(step, quads) {
        for (let i = 0; i < step - 2; ++i) {
            const index = Math.pow(step - 1, 2);
            quads.push([i + 1, i + 2, i + index + 1, i + index + 2]);
        }
    }

    function createUpperCupPolys(step) {
        for (let i = 0; i < step - 1; ++i) {
            polygones.push(new Polygon([0, 1 + (step - 1) * i, 1 + (step - 1) * (i + 1)]));
        }
        polygones.push(new Polygon([0, 1, Math.pow(step - 1, 2) + 1]));
    }

    function createLowerCupPolys(step) {
        const lastIndex = ((step - 1) * step) + 1;
        for (let i = 0; i < step - 1; ++i) {
            polygones.push(new Polygon([lastIndex, (step - 1) * (i + 1), (step - 1) * (i + 2)]));
        }
        polygones.push(new Polygon([lastIndex, lastIndex - 1, step - 1]));
    }

    function createPolygons(step) {
        const quads = [];
        createMainPartPolys(step, quads);
        createVertJointPolys(step, quads);
        createUpperCupPolys(step);
        createLowerCupPolys(step);

        // convert quads to polygones and add it to list
        quads.forEach((quad) => {
            polygones.push(
                new Polygon([quad[0], quad[1], quad[2]]),
                new Polygon([quad[1], quad[2], quad[3]])
            );
        });
    }

    createPoints(x, y, z, radius, step);
    createPolygons(step);
    return new Subject(points, edges, polygones);
}
