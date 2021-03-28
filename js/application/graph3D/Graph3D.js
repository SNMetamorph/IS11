class Graph3D {
    constructor({ WINDOW }) {
        this.WINDOW = WINDOW;
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
}