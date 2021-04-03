class Graph3D {
    constructor({ WINDOW }) {
        this.WINDOW = WINDOW;
        this.math = new Math3D();
    }

    xs(point) {
        const zs = this.WINDOW.center.z;
        const z0 = this.WINDOW.camera.z;
        const x0 = this.WINDOW.camera.x;
        return (point.x - x0) / (point.z - z0) * (zs - z0) + x0;
    }

    ys(point) {
        const zs = this.WINDOW.center.z;
        const z0 = this.WINDOW.camera.z;
        const y0 = this.WINDOW.camera.y;
        return (point.y - y0) / (point.z - z0) * (zs - z0) + y0;
    }

    move(sx, sy, sz, point) {
        this.math.move(sx, sy, sz, point);
    }

    rotateOx(alpha, point) {
        this.math.rotateOx(alpha, point);
    }

    rotateOy(alpha, point) {
        this.math.rotateOy(alpha, point);
    }

    rotateOz(alpha, point) {
        this.math.rotateOz(alpha, point);
    }
}