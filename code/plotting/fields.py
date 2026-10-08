"""Render scalar arrays in derived_data; all intermediate images stay in memory."""
from pathlib import Path
import json
import numpy as np
from PIL import Image
from paths import DERIVED_DIR
from raw_2d_frames import render, fig2_target
from swimmer_foreground import swimmer_mask

def field_2d(figure, identity):
    base=DERIVED_DIR/f'figure_{figure}/data'
    records=json.loads((base/'fields.json').read_text(encoding='utf8'))
    record=next(r for r in records if r['id']==identity)
    with np.load(base/record['array'],allow_pickle=False) as source:
        arrays={k:source[k] for k in ('Vorticity','BodySDF')}
        origin,spacing=source['origin'],source['spacing']
        image=render(arrays,origin,spacing,record['frame'],[],record['summary'])
        mask=swimmer_mask(arrays,origin,spacing,record['frame'])
    if figure=='02':image=fig2_target(image)
    return image,mask,record

def draw_colorbar(pdf, x, y, width, height, scale=1):
    """Vector colour key matching the actual +/-0.8 vorticity map."""
    from reportlab.lib.colors import Color
    for i,value in enumerate(np.linspace(-1,1,128)):
        endpoint=np.array((33,102,172) if value<0 else (178,24,43))/255
        color=1-abs(value)+abs(value)*endpoint
        pdf.setFillColor(Color(*color));pdf.rect(x,y+i*height/128,width,height/128+.05,stroke=0,fill=1)
    pdf.setFillColor(Color(.15,.15,.15));pdf.setFont('Helvetica',7.2)
    for label,fraction in [('-0.8',0),('0',.5),('0.8',1)]:pdf.drawString(x+width+3,y+fraction*height-2,label)



def draw_trajectory(pdf, points, rectangle):
    """Use Figure 2e's exact Catmull-Rom path treatment through every sample."""
    from reportlab.lib.colors import white, HexColor
    DISPLAY_CROP = (0, 0, 1538, 864)
    TRAJECTORY_HALO_PT, TRAJECTORY_WIDTH_PT = 1.55, 1.05
    TRAJECTORY_COLOR = "#66727D"
    padded = np.vstack([points[0], points, points[-1]])
    spans = []
    for i in range(1, len(padded)-2):
        p0,p1,p2,p3 = padded[i-1:i+3]
        t = np.linspace(0,1,10,endpoint=False)[:,None]
        spans.append(.5*(2*p1+(-p0+p2)*t+(2*p0-5*p1+4*p2-p3)*t**2
                         +(-p0+3*p1-3*p2+p3)*t**3))
    smooth = np.vstack([*spans,points[-1:]])
    np.testing.assert_allclose(smooth[::10], points, rtol=0, atol=1e-12)
    x,y,width,height = rectangle
    coordinates = np.column_stack((x+smooth[:,0]*width/DISPLAY_CROP[2],
                                    y+height-smooth[:,1]*height/DISPLAY_CROP[3]))
    path=pdf.beginPath()
    path.moveTo(*coordinates[0])
    for point in coordinates[1:]:
        path.lineTo(*point)
    pdf.saveState()
    clip=pdf.beginPath();clip.rect(*rectangle)
    pdf.clipPath(clip,stroke=0,fill=0)
    pdf.setLineCap(1);pdf.setLineJoin(1)
    for color,width in ((white,TRAJECTORY_HALO_PT),
                        (HexColor(TRAJECTORY_COLOR),TRAJECTORY_WIDTH_PT)):
        pdf.setStrokeColor(color);pdf.setLineWidth(width)
        pdf.drawPath(path,stroke=1,fill=0)
    pdf.restoreState()
