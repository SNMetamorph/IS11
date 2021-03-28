class Graph3DComponent extends Component {
    constructor(options) {
        super(options);
        this.WINDOW = {
            left: -5,
            bottom: -5, 
            width: 10,
            height: 10,
            center: new Point(0, 0, -30),
            camera: new Point(0, 0, -50)
        }
        this.sur = new Surface();
        this.graph2D = new Graph2D({ 
            id: "graph3D", 
            WINDOW: this.WINDOW,
            width: 800,
            height: 600
        });
        this.graph3D = new Graph3D({ WINDOW: this.WINDOW });
        this.printScene();
    }

    clear() {
        this.graph2D.clear('#bbb');
    }

    printSubject(subject) {
        this.graph2D.drawAxes();
        for (let i = 0; i < subject.edges.length; ++i)
        {
            const edge = subject.edges[i];
            const p1 = subject.points[edge.p1];
            const p2 = subject.points[edge.p2];
            this.graph2D.drawLine(this.graph3D.xs(p1), this.graph3D.ys(p1), this.graph3D.xs(p2), this.graph3D.ys(p2))
        }
        for (let i = 0; i < subject.points.length; ++i)
        {
            const point = subject.points[i];
            this.graph2D.drawText(this.graph3D.xs(point), this.graph3D.ys(point), i, 12, 10, -10, "red");
            this.graph2D.drawPoint(this.graph3D.xs(point), this.graph3D.ys(point));
        }
    }

    printScene() {
        this.clear();
        this.printSubject(this.sur.cube(-5, -5));
    }

}