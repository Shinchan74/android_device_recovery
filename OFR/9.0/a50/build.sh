#!/bin/bash
if [ ! -d "/home/velosh/" ]; then
source ~/tmp/config.sh
else
source /home/velosh/config.sh
fi

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
HOSTNAME=´cat /etc/hostname >/dev/null´
distro=$(awk -F= '$1 == "ID" {print $2}' /etc/os-release)

~/tmp/telegram -M "⚒ ***Recovery***: [OrangeFox](https://gitlab.com/OrangeFox) (R11.0)
📱 ***Device***: Samsung Galaxy A50
🖥 ***Machine Host***: $HOSTNAME (OS: $distro)
⚙️ ***Device codename***: a50

📍 ***Note***: Building Recovery started"
SYNC_START=$(date +"%s")

cd "$THIS_DIR/OrangeFox"

./build_ofox.sh

SYNC_END=$(date +"%s")
SYNC_DIFF=$((SYNC_END - SYNC_START))
if [ -f "$THIS_DIR/OrangeFox/out/target/product/a50/OrangeFox-R11.0-Beta-a50.zip" ]; then
   # Output for: Build successfully fine
~/tmp/telegram -M "⚒ ***Recovery***: [OrangeFox](https://gitlab.com/OrangeFox) (R11.0)
📱 ***Device***: Samsung Galaxy A50
🖥 ***Machine Host***: $HOSTNAME (OS: $distro)
⚙️ ***Device codename***: a50

✅ ***Note***: Building completed successfully in $((SYNC_DIFF / 60)) minute(s) and $((SYNC_DIFF % 60)) seconds"

   # Output for: ZIP
~/tmp/telegram -M "📦 ***Recovery***: [OrangeFox](https://gitlab.com/OrangeFox) (R11.0)
📱 ***Device***: Samsung Galaxy A50
⚙️ ***Device codename***: a50
🎈 ***Output***: Recovery ZIP Flasheable

📍 ***Tags***: #a50 #ofr #r11 #beta"
~/tmp/telegram -f "$THIS_DIR/OrangeFox/out/target/product/a50/*a50*.zip" ""

   # Output for: Image
~/tmp/telegram -M "📦 ***Recovery***: [OrangeFox](https://gitlab.com/OrangeFox) (R11.0)
📱 ***Device***: Samsung Galaxy A50
⚙️ ***Device codename***: a50
🎈 ***Output***: Recovery Image

📍 ***Tags***: #a50 #ofr #r11 #beta"
~/tmp/telegram -f "$THIS_DIR/OrangeFox/out/target/product/a50/recovery.img" ""
else
~/tmp/telegram -M "⚒ ***Recovery***: [OrangeFox](https://gitlab.com/OrangeFox) (R11.0)
📱 ***Device***: Samsung Galaxy A50
🖥 ***Machine Host***: $HOSTNAME (OS: $distro)
⚙️ ***Device codename***: a50

❌ ***Note***: Building completed unsuccessfully in $((SYNC_DIFF / 60)) minute(s) and $((SYNC_DIFF % 60)) seconds"
fi

curl --data parse_mode=HTML --data chat_id=$CHATS --data sticker=CAADBQADGgEAAixuhBPbSa3YLUZ8DBYE --request POST https://api.telegram.org/bot$TOKEN/sendSticker
