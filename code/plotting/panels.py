"""Export independently usable scientific panels outside the repository."""
import matplotlib.pyplot as plt
from matplotlib.transforms import Bbox
from paths import external_output


def save_panel(fig, stem, *, axes=None, dpi=360):
    """Select scientific axes already drawn in code; never read a figure input."""
    stem = external_output(stem)
    stem.parent.mkdir(parents=True, exist_ok=True)
    visibility = [(ax, ax.get_visible()) for ax in fig.axes]
    text_visibility = [(text, text.get_visible()) for text in fig.texts]
    if axes is not None:
        selected = set(axes)
        for ax in fig.axes:
            ax.set_visible(ax in selected)
        for text in fig.texts:
            text.set_visible(False)
    fig.canvas.draw()
    if axes is None:
        bounds = "tight"
    else:
        renderer = fig.canvas.get_renderer()
        boxes = [ax.get_tightbbox(renderer) for ax in axes]
        bounds = Bbox.union([box for box in boxes if box is not None])
        bounds = bounds.transformed(fig.dpi_scale_trans.inverted()).padded(0.08)
    try:
        for extension in ("pdf", "svg", "png"):
            options = {"CreationDate": None, "ModDate": None} if extension == "pdf" else None
            with plt.rc_context({"pdf.fonttype": 42, "svg.fonttype": "none"}):
                fig.savefig(stem.with_suffix("." + extension), dpi=dpi,
                            bbox_inches=bounds, facecolor="white", metadata=options)
    finally:
        for ax, value in visibility:
            ax.set_visible(value)
        for text, value in text_visibility:
            text.set_visible(value)


def save_document(document, stem):
    """Export a vector PDF drawn in memory by the scientific Python code."""
    stem = external_output(stem)
    stem.parent.mkdir(parents=True, exist_ok=True)
    if len(document) != 1:
        raise ValueError("A scientific panel must have one page")
    # Normalize ReportLab's ASCII85 content streams for editable-text audits.
    for xref in range(1, document.xref_length()):
        if document.xref_is_stream(xref) and document.xref_get_key(xref, "Subtype")[1] != "/Image":
            document.update_stream(xref, document.xref_stream(xref), compress=False)
    document.save(stem.with_suffix(".pdf"), garbage=4, deflate=True)
    page = document[0]
    page.get_pixmap(dpi=360, alpha=False).save(stem.with_suffix(".png"))
    stem.with_suffix(".svg").write_text(page.get_svg_image(text_as_path=False), encoding="utf-8")
    document.close()
