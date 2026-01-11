#!/bin/bash
# Whisper Speech-to-Text für Claude Code
# Nimmt X Sekunden Audio auf dem Mac auf, transkribiert via Office API

MAC_HOST="dieterhorst@192.168.42.17"
OFFICE_API="https://192.168.42.253:3000/api/stt"
DURATION="${1:-5}"  # Default 5 Sekunden, oder als Parameter

echo "🎤 Aufnahme auf Mac: ${DURATION} Sekunden..."
echo "   Sprich jetzt!"
echo ""

# Audio auf Mac aufnehmen
ssh "$MAC_HOST" "python3 << 'PYEOF'
import sys
sys.path.insert(0, '/Users/dieterhorst/Library/Python/3.9/lib/python/site-packages')
import sounddevice as sd
import numpy as np
import wave

duration = $DURATION
sample_rate = 16000

print(f'Recording {duration}s...')
audio = sd.rec(int(duration * sample_rate), samplerate=sample_rate, channels=1, dtype='float32')
sd.wait()

with wave.open('/tmp/whisper-audio.wav', 'wb') as wf:
    wf.setnchannels(1)
    wf.setsampwidth(2)
    wf.setframerate(sample_rate)
    wf.writeframes((audio * 32767).astype('int16').tobytes())
print('Done')
PYEOF" 2>/dev/null

echo "⏳ Hole Audio..."
scp -q "$MAC_HOST:/tmp/whisper-audio.wav" "/tmp/whisper-audio.wav" 2>/dev/null

if [ ! -f "/tmp/whisper-audio.wav" ]; then
    echo "❌ Keine Audio-Datei"
    exit 1
fi

echo "⏳ Transkribiere..."

RESULT=$(curl -s -k -X POST "$OFFICE_API" \
    -F "file=@/tmp/whisper-audio.wav;type=audio/wav")

TEXT=$(echo "$RESULT" | python3 -c "import sys,json; print(json.load(sys.stdin).get('text',''))" 2>/dev/null)

if [ -n "$TEXT" ]; then
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "✅ $TEXT"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
else
    echo "❌ Fehler: $RESULT"
fi

rm -f /tmp/whisper-audio.wav
ssh "$MAC_HOST" "rm -f /tmp/whisper-audio.wav" 2>/dev/null
