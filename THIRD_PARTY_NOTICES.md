# Third-party notices

Our code is licensed under the [Apache License 2.0](LICENSE).
Third-party code and portions adapted from it retain their upstream copyright
and license terms. The Apache license does not replace those terms. This file
accompanies the source distribution and preserves the notices for the WaterLily
components used here.

## WaterLily.jl — MIT

Upstream: [WaterLily.jl](https://github.com/WaterLily-jl/WaterLily.jl).

WaterLily is installed as a Julia dependency; its complete package source is
not vendored in this repository. Our code also contains source adaptations:

- The `measure!` override in the file below adapts
  [WaterLily 1.6.1, src/Body.jl](https://github.com/WaterLily-jl/WaterLily.jl/blob/29f9f4362faf7493fe4aacdc943f5e5ade83f3d0/src/Body.jl).
  Our code changes the gate to inspect both adjacent pressure cells, retains the
  signed distance at each face, and selects PCG pressure smoothing.
  - [3D experiment runtime](code/simulation/3d/experiments/cases/dogfish_3d_shape_policy/src/reflection_equivariant_ibm3d.jl)
- The surface force, moment and power routines in the simulation, evaluation
  and validation sources use the traction and surface-integration conventions
  of [WaterLily's Metrics.jl](https://github.com/WaterLily-jl/WaterLily.jl/blob/29f9f4362faf7493fe4aacdc943f5e5ade83f3d0/src/Metrics.jl).
  The notice below also covers any upstream-derived portions of these routines.

WaterLily-derived portions remain MIT-licensed; our modifications
are Apache-2.0. These numerical source snapshots are kept byte-for-byte for reproducibility;
their attribution is recorded here rather than inserted into the snapshots.

The following notice is reproduced from the upstream
[1.6.1 LICENSE.md](https://github.com/WaterLily-jl/WaterLily.jl/blob/29f9f4362faf7493fe4aacdc943f5e5ade83f3d0/LICENSE.md);
the [1.8.0 notice](https://github.com/WaterLily-jl/WaterLily.jl/blob/2a2b2ba2eeacc885d84e346f743b72a34e0b713f/LICENSE.md)
is identical.

The WaterLily.jl package is licensed under the MIT "Expat" License:

> Copyright (c) 2020: Gabriel Weymouth.
>
> Permission is hereby granted, free of charge, to any person obtaining a copy
> of this software and associated documentation files (the "Software"), to deal
> in the Software without restriction, including without limitation the rights
> to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> copies of the Software, and to permit persons to whom the Software is
> furnished to do so, subject to the following conditions:
>
> The above copyright notice and this permission notice shall be included in all
> copies or substantial portions of the Software.
>
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
> AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> SOFTWARE.
>

## ParametricBodies.jl — MIT

Upstream: [ParametricBodies.jl](https://github.com/WaterLily-jl/ParametricBodies.jl).
The shared validation manifest pins version 0.3.4, Git tree
`6dec8d3f84caf9640856f8b53815022aceb99749`.

The parametric NACA geometry in
[oscillating-foil validation](code/simulation/validation/2d/oscillating_foil2d.jl)
uses the reflected upper-surface construction shown in
[example/TwoD_TandemAirfoil.jl](https://github.com/WaterLily-jl/ParametricBodies.jl/blob/d21e62cd0a605114c7e19012fcdb9d6153a84e15/example/TwoD_TandemAirfoil.jl).
Our code adapts it for a single NACA0016 foil and the validation's motion and
configuration. Any upstream-derived portions retain the following MIT terms;
our modifications are Apache-2.0.

The following notice is reproduced from the upstream
[0.3.4 LICENSE](https://github.com/WaterLily-jl/ParametricBodies.jl/blob/d21e62cd0a605114c7e19012fcdb9d6153a84e15/LICENSE).

```text
MIT License

Copyright (c) 2023 Gabriel Weymouth

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## Redistribution

Keep the applicable upstream copyright and permission notices with any copies
or substantial portions of the corresponding third-party code, including
adaptations. If exporting a source subtree separately, include the relevant
sections of this file and the root Apache license for our code.

Other dependencies retain their own licenses. This notice records the reviewed
WaterLily-related components; it is not a complete license inventory of all
transitive dependencies. Existing EvE attribution notices remain in
[code/eve/2d/NOTICE](code/eve/2d/NOTICE) and
[code/eve/3d/NOTICE](code/eve/3d/NOTICE).
