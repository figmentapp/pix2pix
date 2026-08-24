#!/usr/bin/env bash
# Extract ~N frames uniformly spread across a video, saved as JPGs.
#
# Usage:
#   ./extract_frames.sh [video] [output_dir] [n_frames]
#
# Defaults are set for the ai-secrett "people.mov" dataset.
# Output filenames are frame-0000.jpg ... frame-NNNN.jpg (4-digit zero-pad).

set -euo pipefail

INPUT="${1:-/Users/fdb/Work/2026-ai-secrett/prep/people.mov}"
OUTPUT_DIR="${2:-datasets/ai-secrett}"
N_FRAMES="${3:-8000}"

if [[ ! -f "$INPUT" ]]; then
    echo "Error: video not found at $INPUT" >&2
    exit 1
fi

mkdir -p "$OUTPUT_DIR"

# Probe duration (seconds, float) and compute target output FPS.
# Sampling at (N_FRAMES / duration) fps places kept frames uniformly in time.
DURATION=$(ffprobe -v error -select_streams v:0 \
    -show_entries format=duration \
    -of default=noprint_wrappers=1:nokey=1 "$INPUT")

FPS=$(awk "BEGIN { printf \"%.6f\", $N_FRAMES / $DURATION }")

echo "Input:      $INPUT"
echo "Duration:   ${DURATION}s"
echo "Target:     $N_FRAMES frames -> $FPS fps"
echo "Output:     $OUTPUT_DIR/frame-XXXX.jpg"
echo ""

ffmpeg -hide_banner -loglevel warning -stats -y \
    -i "$INPUT" \
    -vf "fps=$FPS" \
    -q:v 2 \
    -start_number 0 \
    "$OUTPUT_DIR/frame-%04d.jpg"

COUNT=$(find "$OUTPUT_DIR" -maxdepth 1 -name 'frame-*.jpg' | wc -l | xargs)
echo ""
echo "Extracted $COUNT JPG frames into $OUTPUT_DIR/"
