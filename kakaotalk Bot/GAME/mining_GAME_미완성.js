var pickaxes = [
  {name: "나무 곡괭이",price: 100,level: 1},
  {name: "철 곡괭이", price: 1000, level: 2},
  {name: "다이아몬드 곡괭이", price: 5000, level: 4},
  {name: "에메랄드 곡괭이", price: 10000, level: 6}
];
var mineralPrices = {
  "금": 500,
  "은": 250,
  "다이아몬드": 1000,
  "철": 150,
  "석탄": 50,
};
var inventory = {
  "gold": 1000
}; // 사용자의 인벤토리
function responseFix(room, msg, sender, isGroupChat, replier, imageDB, packageName) {
  if (msg === ".채광") {
    var minerals = ["금", "은", "다이아몬드", "철", "석탄"];
    var pickaxeName = "나무 곡괭이";
    var pickaxeLevel = inventory["나무 곡괭이"];
    var availableMinerals = [];
    var minLevel = 0;
    var maxLevel = 0;
    if (pickaxeLevel >= 1) {
      availableMinerals.push("석탄");
      minLevel = 1;
      maxLevel = 3;
    }
    if (pickaxeLevel >= 2) {
      availableMinerals.push("철");
      minLevel = 1;
      maxLevel = 4;
    }
    if (pickaxeLevel >= 3) {
      availableMinerals.push("은");
      minLevel = 2;
      maxLevel = 5;
    }
    if (pickaxeLevel >= 4) {
      availableMinerals.push("금");
      minLevel = 3;
      maxLevel = 6;
    }
    if (pickaxeLevel >= 5) {
      availableMinerals.push("다이아몬드");
      minLevel = 6;
      maxLevel = 7;
    }
    if (availableMinerals.length > 0) {
      var eligibleMinerals = minerals.filter(function (mineral) {
        return mineralPrices[mineral] / 100 === mineralLevel && availableMinerals.indexOf(mineral) !== -1;
      });
      if (eligibleMinerals.length > 0) {
        var mineralLevel = Math.floor(Math.random() * (maxLevel - minLevel) + minLevel);
        var mineral = eligibleMinerals[Math.floor(Math.random() * eligibleMinerals.length)];
        replier.reply("채굴 결과: " + mineral + "을(를) 얻었습니다!");
        // 광물을 채굴한 후 인벤토리에 추가
        if (inventory[mineral]) {
          inventory[mineral]++;
        } else {
          inventory[mineral] = 1;
        }
      } else {
        replier.reply("현재 곡괭이 레벨로는 채굴할 수 있는 광물이 없습니다.");
      }
    }
  }
  if (msg === ".상점") {
    replier.reply("곡괭이: " + pickaxePrices[pickaxeName] + "원, 광물 판매 가격: ");
    for (var mineral in mineralPrices) {
      replier.reply(mineral + ": " + mineralPrices[mineral] + "원");
    }
  }
  if (msg.startsWith(".구매 ")) {
    var itemName = msg.split(" ")[1];
    if (pickaxePrices[itemName]) {
      if (money >= pickaxePrices[itemName]) {
        money -= pickaxePrices[itemName];
        inventory[itemName] = 1;
        replier.reply(itemName + "을(를) 구매하였습니다.");
      } else {
        replier.reply("돈이 부족합니다.");
      }
    }
    if (msg.startsWith('.판매 ')) {
      var mineral = msg.substr(4);
      if (inventory[mineral]) {
        var price = mineralPrices[mineral] * inventory[mineral];
        inventory[mineral] = 0;
        replier.reply(mineral + " " + price + "원에 판매 완료!");
      } else {
        replier.reply("인벤토리에 해당 광물이 없습니다.");
      }
    }
    if (msg === '.인벤') {
      var inventoryStr = "인벤토리:\n";
      for (var mineral in inventory) {
        if (inventory[mineral] > 0) {
          inventoryStr += mineral + ": " + inventory[mineral] + "개\n";
        }
      }
      replier.reply(inventoryStr);
    }
  }














































function onNotificationPosted(sbn, sm) {
  var packageName = sbn.getPackageName();
  if (!packageName.startsWith("com.kakao.tal")) return;
  var actions = sbn.getNotification().actions;
  if (actions == null) return;
  var userId = sbn.getUser().hashCode();
  for (var n = 0; n < actions.length; n++) {
      var action = actions[n];
      if (action.getRemoteInputs() == null) continue;
      var bundle = sbn.getNotification().extras;

      var msg = bundle.get("android.text").toString();
      var sender = bundle.getString("android.title");
      var room = bundle.getString("android.subText");
      if (room == null) room = bundle.getString("android.summaryText");
      var isGroupChat = room != null;
      if (room == null) room = sender;
      var replier = new com.xfl.msgbot.script.api.legacy.SessionCacheReplier(packageName, action, room, false, "");
      var icon = bundle.getParcelableArray("android.messages")[0].get("sender_person").getIcon().getBitmap();
      var image = bundle.getBundle("android.wearable.EXTENSIONS");
      if (image != null) image = image.getParcelable("background");
      var imageDB = new com.xfl.msgbot.script.api.legacy.ImageDB(icon, image);
      com.xfl.msgbot.application.service.NotificationListener.Companion.setSession(packageName, room, action);
      if (this.hasOwnProperty("responseFix")) {
          responseFix(room, msg, sender, isGroupChat, replier, imageDB, packageName, userId != 0);
      }
  }
 } 
}
