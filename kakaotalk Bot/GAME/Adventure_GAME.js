const PATH = android.os.Environment.getExternalStorageDirectory().getAbsolutePath() + "/darkapple/fishing/userData.txt";
const userData = JSON.parse(FileStream.read(PATH) === null ? FileStream.write(PATH, "{}") : FileStream.read(PATH));
const isFishing = {};
const fishs = ["🐵","🐒","🦍","🦧","🐶","🐕","🦮","🐕‍🦺","🐩","🐺","🦊","🦝","🐱","🐈","🐈‍⬛","🦁","🐯","🐅","🐆","🐴","🫎","🫏","🐎","🦄","🦓","🦌","🦬","🐮","🐂","🐃","🐄","🐷","🐖","🐗","🐽","🐏","🐑","🐐","🐪","🐫","🦙","🦒","🐘","🦣","🦏","🦛","🐭","🐁","🐀","🐹","🐰","🐇","🐿","🦫","🦔","🦇","🐻","🐨","🐻‍❄️","🐼","🦥","🦦","🦨","🦘","🦡","🐧","🦃","🐔","🐓","🐣","🐤","🐥","🐦","🕊","🦅","🦆","🦢","🦉","🦤","🪶","🦩","🦚","🦜","🪽","🐦‍⬛","🪿","🐸","🐢","🦎","🐍","🐲","🐉","🥿","👞","👟","👠","🥾","👡","🐊","💍","💩","🐳","🐋","🐬","🦭","🐟","🐠","🐡","🦈","🐙","🦀","🦂","🪸","🐚","🪼","🪿","🍃","<에픽>\n🍓","루이스","빌","조이","프란시스","닉","로셸","엘리스","코치","🦪","해파리", "말미잘", "🦐", "🦞", "고래", "문어", "🦑", "돌고래", "바다표범", "가다랑어", "가오리", "갈치", "개복치", "광어", "농어", "대구", "도미", "멸치", "민어", "방어", "복어", "상어", "아귀", "연어", "우럭", "장화", "임연수어", "잉어", "장어", "돈까스", "돌", "먼지"];
function response(room, msg, sender, igc, replier) {
  if (msg === ".탐험") {
    checkUser(sender);
    if (!isFishing[sender]) {
      startFishing(sender, userData[sender], replier);
    } else {
      replier.reply("🔦탐험 중입니다..");
    }
  }
  if (msg === '.탐험 레벨') {
    checkUser(sender);
    replier.reply(sender + "‭님의 탐험 레벨은 " + userData[sender].level + "입니다\n" + "다음 레벨까지 필요한 경험치: " + userData[sender].point + "/" + getPoint(userData[sender].level));
  }
  if (msg === ".인벤토리") {
    checkUser(sender);
    replier.reply(getInventory(sender));
  }
  if (msg === ".랭킹") {
    replier.reply("탐험 랭킹입니다\n" + "​".repeat(1000) + getRank());
  }
}
function checkUser(name) {
  if (!Object.prototype.hasOwnProperty.call(userData, name)) {
    userData[name] = {
  inventory: [], 
  level: 1, 
  point: 0};
    saveData();
  }
  if (!Object.prototype.hasOwnProperty.call(isFishing, name)) {
    isFishing[name] = false;
  }
}
function saveData() {
  FileStream.write(PATH, JSON.stringify(userData));
}
function startFishing(name, data, send) {
  isFishing[name] = true;
  send.reply(name + "‭님이 🔦탐험을 시작합니다.");
  java.lang.Thread.sleep((10 + (Math.random() * 20 | 0)) * 1000);
  send.reply(getRandomFish(data, data.level));
  isFishing[name] = false;
}
function checkLevel(data) {
  while (data.level < 999) {
    if (data.point > getPoint(data.level)) {
      data.level++;
    } else {
      break;
    }
  }
  saveData();
}
function getPoint(level) {
  return level * level * level + level * 500;
}
function getRandomFish(data, level, name,send,sender) {
  var chance = Math.pow(level, 1 / 3) * 21;
  var result = (0.7 + (Math.random() * 0.5)) * level * 10;
  while (chance < (Math.random() * 100)) {
    result *= 1 + Math.random() * 0.04;
  }
  result = Math.floor(result);
  var fish = randomName();
  data.inventory.push([result, fish]);
  data.point += result;
  checkLevel(data);
  saveData();
  return "🎉위대한 발견!\n" + result + "cm " + fish + "를(을) 발견했다.";
}
function randomName() {
  return fishs[fishs.length * Math.random() | 0];
}
function getInventory(name) {
  let i1 = userData[name].inventory;
  return "​".repeat(1000) + Object.keys(i1).sort((y, x) => i1[x][0] - i1[y][0]).map(x => i1[x][0] + "cm " + i1[x][1]).join("\n");
}
function getRank() {
  return Object.keys(userData).sort(function(x, y) {
  let i2 = userData[x].inventory;
  let i1 = userData[y].inventory;
  if (!i1.length) {
    return true;
  }
  if (!i2.length) {
    return false;
  }
  return i1[Object.keys(i1).sort((y, x) => i1[x][0] - i1[y][0])[0]][0] - i2[Object.keys(i2).sort((y, x) => i2[x][0] - i2[y][0])[0]][0];
}).map((x, xx) => (xx + 1) + "위 " + x + "‭" + getBigfish(x)).join("\n\n");
}
function getBigfish(name) {
  let i1 = userData[name].inventory;
  return i1.length === 0 ? "" : "(" + i1[Object.keys(i1).sort((y, x) => i1[x][0] - i1[y][0])[0]][0] + "cm)";
}
