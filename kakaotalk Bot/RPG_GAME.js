const F = FileStream;
const path = 'sdcard/Attack RPG0/';
function write(s, a) {
    F.write(path + s, a);
}
function read(s) {
    return F.read(path + s);
}
function Wear(s, a, p) {
    if (!!read(s + '/info/' + a)) {
        Give(s, read(s + '/info/' + a), 1);
    }
    write(s + '/info/' + a, p);
}
function IsPoint(s, a) {
    return read(s + '/info/place') == a;
}
function Give(s, a, b) {
    for (var l = 0; l < b; l++) {
        write(s + '/info/inventory', read(s + '/info/inventory') + '​' + a);
    }
}
function Add(s, a) {
    write(s + '/info/money', Number(read(s + '/info/money')) + Number(a));
}
function HasMoney(s) {
    return read(s + '/info/money');
}
function IsPlayer(s) {
        (!F.read(path + 'players')) ? F.write(path + 'players', null + '​') : '';
    return F.read(path + 'players').split('​').indexOf(s.toString()) != -1;
}
function AddPlayer(s) {
    F.write(path + 'players', F.read(path + 'players') + '​' + s);
}
function Delete(s, q) {
    var a = read(s + '/info/inventory').split('​');
    a.splice(a.indexOf(q), 1);
    write(s + '/info/inventory', a.join('​'));
}
const map = {
    상점: {
    wait: 6, 
    Can: ['초원 마을'], 
    difficulty: 'easy', 
    information: '아이템을 구매할 수 있는 상점입니다', 
    shop: {
    '암살자의 검': {
    information: '날렵한 암살자의 검입니다.', 
    buy: 50, 
    damage: 84.5, 
    break: 0, 
    max: 1, 
    type: 'Sword', 
    tooltype: 'attack'}, 
    곡괭이: {
    information: '돌을 빠르게 캘 수 있는 광질 곡괭이입니다.', 
    buy: 23, 
    damage: 2, 
    break: 5, 
    max: 1, 
    type: 'Tool', 
    tooltype: 'attack'}, 
    '체력 포션': {
    information: '즉시 체력을 채울 수 있습니다.', 
    buy: 52, 
    damage: -30, 
    break: 0, 
    max: 5, 
    type: 'Potion'}, 
    막대기: {
    information: '기본 아이템입니다.', 
    buy: 12, 
    damage: 12, 
    break: 0, 
    max: 5, 
    type: 'Tool', 
    tooltype: 'attack'}, 
    '돌 검': {
    information: '돌로 이루어진 검입니다.', 
    buy: 89, 
    damage: 47, 
    break: 0, 
    max: 2, 
    type: 'Tool', 
    tooltype: 'attack'}}}, 
    '초원 마을': {
    wait: 9, 
    Can: ['상점', '사냥터', '디르비아 숲'], 
    information: '시작 지형입니다', 
    difficulty: 'easy'}, 
    '사냥터': {
    wait: 5, 
    Can: ['초원 마을', '지옥'], 
    information: '중급 몬스터가 나오는 지형입니다', 
    difficulty: 'normal'}, 
    '지옥': {
    level: 50, 
    wait: 6, 
    Can: ['사냥터'], 
    information: '오지 마세요', 
    difficulty: 'hard'}, 
    '디르비아 숲': {
    level: 15, 
    wait: 4.5, 
    Can: ['초원 마을', '지옥'], 
    information: '꽤 강한 몬스터들이 많은 지형입니다', 
    difficulty: 'special'}};
Array.prototype.Random = function() {
    return this[Math.random() * this.length | 0];
};
var www = map.상점.shop;
const monsters = {
    easy: {
    토끼: {
    hp: 100, 
    attack: 2, 
    defence: 3, 
    rewords: ['토끼 가죽', '토끼의 심장', '토끼 고기'], 
    xp: 16}, 
    개: {
    hp: 120, 
    attack: 13, 
    defence: 5, 
    rewords: ['개 가죽', '개 다리'], 
    xp: 32}, 
    까마귀: {
    hp: 70, 
    attack: 8, 
    defence: 13, 
    rewords: ['깃털'], 
    xp: 65}}, 
    normal: {
    지킴이: {
    hp: 280, 
    attack: 37, 
    defence: 13, 
    rewords: ['철', '철 검'], 
    xp: 320}}, 
    hard: {
    '사신': {
    hp: 19000, 
    attack: 720, 
    defence: 98, 
    rewords: ['사신의 낫'], 
    xp: 180000}}, 
    special: {
    '소련': {
    hp: 7300, 
    attack: 324, 
    defence: 21, 
    rewords: ['물병'], 
    xp: 37000}, 
    '인병': {
    hp: 9300, 
    attack: 234, 
    defence: 19, 
    rewords: ['물병'], 
    xp: 23651}}};
var item = {
    '체력 포션': {
    heal: 30, 
    type: 'Potion'}, 
    '마나 포션': {
    add: 20, 
    type: 'Potion'}, 
    '토끼 고기': {
    heal: 1, 
    type: 'Food'}, 
    '가죽 갑옷': {
    defence: 6, 
    type: 'Defensive', 
    tooltype: 'defence'}, 
    '철 검': {
    damage: 32, 
    type: 'Sword', 
    tooltype: 'attack'}, 
    '사신의 낫': {
    damage: 180, 
    type: 'Sword', 
    tooltype: 'attack'}};
var items = {};
Object.keys(www).forEach(s => items[s] = www[s]);
Object.keys(item).forEach(s => items[s] = item[s]);
const explain = {
    회원가입: '가입합니다.', 
    튜토리얼: '튜토리얼이 나옵니다.', 
    이동: '해당 지역으로 이동합니다.', 
    맵: '현재 맵을 봅니다.', 
    정보: '자신의 정보를 봅니다.', 
    '맵 정보': '맵의 정보를 확인합니다.', 
    구매: '상점에서 해당 아이템을 구입합니다.', 
    인벤: '자신의 인벤토리를 봅니다.', 
    사용: '자신의 인벤토리에 있는 아이템을 사용합니다.', 
    공격: '대상을 자동으로 공격합니다.', 
    로그아웃: '다시 로그인하기 전까지 모든 명령어를 사용할 수 없으며 공격을 받지 않습니다.', 
    로그인: '로그인합니다.', 
    아이템: '해당 아이템의 정보를 봅니다.', 
    '빠른 전투': '빠른 전투 모드를 켜고 끕니다.'};
response = (room, msg, sender, isGroupChat, replier, imageDB) => {
    try {
        sender = sender.replace(/|　|/g, '').trim();
        msg = msg.replace(/|　|/g, '').trim();
        var image = imageDB.getProfileHash();
        const re = '□■□■□■ ' + sender + ' ■□■□■□\n';
        if (msg == '!회원가입') {
            if (IsPlayer(image)) {
                replier.reply(re + '이미 가입자입니다.');
                return;
            }
            AddPlayer(image);
            replier.reply(re + '가입 완료!\n!튜토리얼');
            write(image + '/info/hp', 100);
            write(image + '/info/mana', 100);
            write(image + '/info/maxhp', 100);
            write(image + '/info/maxmana', 100);
            write(image + '/info/level', 1);
            write(image + '/info/xp', 1);
            write(image + '/info/up', 200);
            write(image + '/info/attack', '막대기');
            write(image + '/info/defence', '가죽 갑옷');
            write(image + '/info/place', '초원 마을');
            write(image + '/info/die', false);
            write(image + '/info/money', 5);
            write(image + '/info/inventory', '체력 포션\u200b체력 포션');
            write(pa + 'log', true);
            write(path + 'map/info/초원 마을/monsters', '토끼\u200b개');
            write(pa + 'speed', false);
        }
        if (IsPlayer(image)) {
            const pa = image + '/info/';
            const all = '​'.repeat(500);
            if (read(pa + 'die') == 'true') 
                return;
            if (read(pa + 'hp') <= 0) {
                replier.reply(re + '사망하셨습니다.\n10분 후 부활합니다.');
                write(pa + 'die', true);
                setTimeout(() => {
                write(pa + 'die', false);
                write(pa + 'hp', read(pa + 'maxhp'));
                write(pa + 'mana', read(pa + 'maxmana'));
                }, 600000);
            }
            if (msg[0] == '!') {
                msg = msg.slice(1);
                if (msg == '로그인' && read(pa + 'log') == 'false') {
                    write(pa + 'log', true);
                    replier.reply(re + '로그인 했습니다!');
                }
                if (read(pa + 'log') == 'false') 
                    return;
                if (msg == '로그아웃') {
                    write(pa + 'log', false);
                    replier.reply(re + '로그아웃 했습니다!');
                }
                if (msg == '빠른 전투') {
                    write(pa + 'speed', (read(pa + 'speed') == 'true') ? false : true);
                    replier.reply('빠른 전투 모드를 ' + (read(pa + 'speed') == 'true' ? '켜짐' : '꺼짐') + ' 상태로 변경했습니다.');
                }
                if (msg == '튜토리얼') {
                    replier.reply(Object.keys(explain).map(s => '!' + s + ': ' + explain[s]).join('\n'));
                }
                if (msg == '맵') {
                    replier.reply('□■□■□■□■ [ 맵 ] ■□■□■□■□\n' + all + '\n\n\n현재 [ ' + read(pa + 'place') + ' ] 지형에 있습니다.\n\n\n[ 갈 수 있는 지형 ]\n' + Object.keys(map).filter(s => map[s].Can.includes(read(pa + 'place'))).map((s, i) => (i + 1) + '. ' + s).join('\n'));
                }
                if (msg == '정보') {
                    replier.reply(re + all + '\n\n\n[ ' + read(pa + 'level') + ' Level ]\n[ ' + read(pa + 'xp') + '/' + read(image + '/info/up') + ' XP ]\n\n무기: ' + read(pa + 'attack') + '\n방어구: ' + read(pa + 'defence') + '\n\n\n[ 체력 ] (' + read(pa + 'hp') + ')\n' + '❤ \xd7 ' + read(pa + 'hp') + '\n\n[ 자금 ] (' + read(pa + 'money') + ')\n' + 'ⓒ \xd7 ' + read(pa + 'money'));
                }
                if (msg.indexOf('이동 ') == 0) {
                    var tar = msg.slice(3).trim();
                    if (Object.keys(map).indexOf(tar) == -1) {
                        replier.reply(re + '그런 지형은 없습니다.');
                        return;
                    }
                    if (map[tar].Can.indexOf(read(pa + 'place')) == -1) {
                        replier.reply(re + '그곳은 갈 수 없습니다.\n\n[ 갈 수 있는 지형 ]\n' + Object.keys(map).filter(s => map[s].Can.includes(read(pa + 'place'))).join(', '));
                        return;
                    }
                    if (map[tar].level) {
                        if (map[tar].level > read(pa + 'level')) {
                            replier.reply('그 지형은 ' + map[tar].level + '레벨부터 입장하실 수 있습니다.');
                            return;
                        }
                    }
                    replier.reply(re + '이동 중입니다....');
                    java.lang.Thread.sleep(map[tar].wait * 1000);
                    write(pa + 'place', tar);
                    replier.reply(re + '[ ' + tar + ' ] 지형에 도착했습니다.');
                    var pp = [];
                    for (var s = 0; s < 5; s++) 
                        pp.push(Object.keys(monsters[map[tar].difficulty]).Random());
                    write(path + 'map/info/' + tar + '/monsters', pp.join('​'));
                }
                if (msg == '광질' && read(pa + 'place') == '초원 마을' && read(pa + 'attack') == '곡괭이') {
                    var plus = Math.round(Math.random() * map.상점.shop.곡괭이.break);
                    replier.reply(re + '광질을 하여 [ ' + plus + ' ] 코인을 얻었습니다.');
                    write(pa + 'money', +read(pa + 'money') + plus);
                    var f = Math.random() * 50 | 0;
                    if (f == 1) {
                        replier.reply(re + '곡괭이가 깨졌습니다!');
                        write(pa + 'attack', '막대기');
                    }
                }
                if (msg == '맵 정보') {
                    var t = map[read(pa + 'place')];
                    if (read(pa + 'place') != '상점') {
                        replier.reply('[ ' + read(pa + 'place') + '의 지형 정보 ]\n' + all + '\n\n        [ ' + t.information + ' ]\n\n\n[ 몬스터 ]\n' + read(path + 'map/info/' + read(pa + 'place') + '/monsters').split('​').map((s, q) => (q + 1) + '. ' + s).join('\n'));
                        return;
                    }
                    replier.reply('[ ' + read(pa + 'place') + '의 지형 정보 ]\n' + all + '\n\n        [ ' + map[read(pa + 'place')].information + ' ]\n\n\n' + Object.keys(t.shop).map(s => '      [ ' + s + ' ]\n➺ ' + t.shop[s].information + '\n\n  ▸ ' + t.shop[s].buy + '$\n  ▸ ' + t.shop[s].damage + ' Damage\n  ▸ ' + t.shop[s].break + ' Digging Speed\n  ▸ ' + t.shop[s].max + ' Max\n  ▸ ' + t.shop[s].type + ' Type').join('\n\n\n\n'));
                }
                if (msg.indexOf('구매 ') == 0) {
                    msg = msg.slice(3).trim();
                    if (!IsPoint(image, '상점')) {
                        replier.reply(re + '상점에서만 사용 가능한 명령어입니다.');
                        return;
                    }
                    if (Object.keys(map.상점.shop).indexOf(msg) == -1) {
                        replier.reply(re + '그런 품목은 없습니다.');
                        return;
                    }
                    if (map.상점.shop[msg].buy > HasMoney(image)) {
                        replier.reply(re + '돈이 모자랍니다.');
                        return;
                    }
                    try {
                        if (map.상점.shop[msg].max > read(pa + 'inventory').match(RegExp(msg, g)).length) {
                            replier.reply(re + '최대 소유 개수를 초과할 수 없습니다!');
                            return;
                        }
                    }          catch (a) {
}
                    Add(image, -map.상점.shop[msg].buy);
                    Give(image, msg, 1);
                    replier.reply(re + '구매했습니다!');
                }
                if (msg == '인벤') {
                    replier.reply('[ ' + sender + ' 님의 인벤토리 ]\n' + all + '\n\n' + read(pa + 'inventory').split('​').sort().map((s, q) => String(q + 100001).slice(1) + ' ▹ ' + s).join('\n'));
                }
                if (msg.indexOf('사용 ') == 0) {
                    msg = msg.slice(3).trim();
                    if (read(pa + 'inventory').split('​').indexOf(msg) == -1) {
                        replier.reply(re + '소유하고 있지 않은 아이템입니다.');
                        return;
                    }
                    var Type = items[msg].type;
                    Delete(image, msg);
                    if (Type == 'Potion') {
                        replier.reply(re + '[ ' + msg + ' ] 사용 완료했습니다.');
                        if (msg == '체력 포션') {
                            var effect = 'hp';
                            write(pa + effect, Number(read(pa + effect)) + Number(items[msg].heal));
                                                        (Number(read(pa + 'max' + effect)) < Number(read(pa + effect))) ? write(pa + effect, read(pa + 'max' + effect)) : '';
                        } else if (msg == '마나 포션') {
                            var effect = 'mana';
                            write(pa + effect, Number(read(pa + effect)) + Number(items[msg].add));
                                                        (+read(pa + 'max' + effect) < +read(pa + effect)) ? write(pa + effect, read(pa + 'max' + effect)) : '';
                        }
                    } else if (Type == 'Tool' || Type == 'Sword') {
                        Wear(image, items[msg].tooltype, msg);
                        replier.reply(re + '장착됨!');
                    } else if (Type == 'Food') {
                        var effect = 'hp';
                        Delete(image, msg);
                        write(pa + 'hp', Number(read(pa + 'hp')) + +items[msg].hp);
                                                (+read(pa + 'max' + effect) < +read(pa + effect)) ? write(pa + effect, read(pa + 'max' + effect)) : '';
                        replier.reply(re + '먹었습니다.');
                    } else if (Type == 'Defensive') {
                        Wear(image, items[msg].tooltype, msg);
                        replier.reply(re + '착용 완료!');
                    } else {
                        replier.reply(re + '사용할 수 없는 아이템입니다.');
                        Give(image, msg);
                    }
                }
                if (msg.indexOf('아이템 ') == 0) {
                    msg = msg.slice(4).trim();
                    try {
                        replier.reply(Object.keys(items[msg]).map(s => s + ': ' + items[msg][s]).join('\n'));
                    }          catch (e) {
    replier.reply('그런 아이템은 없습니다.');
}
                }
                if (msg.indexOf('공격 ') == 0) {
                    msg = msg.slice(3).trim();
                    try {
                        if (read(path + 'map/info/' + read(pa + 'place') + '/monsters').split('​').indexOf(msg) == -1) {
                            replier.reply(re + '그런 몬스터는 해당 지역에 존재하지 않습니다.');
                            return;
                        }
                    }          catch (e) {
    replier.reply(re + '그런 몬스터는 해당 지역에 존재하지 않습니다.');
    return;
}
                    var HP = read(pa + 'hp');
                    var hp;
                    var hh;
                    for (var w = 0; w < Object.keys(monsters).length; w++) {
                        if (!hp) {
                            try {
                                hp = monsters[Object.keys(monsters)[w]][msg].hp;
                                hh = monsters[Object.keys(monsters)[w]][msg];
                            }              catch (i) {
    hp = '';
}
                        }
                    }
                    var po = read(pa + 'place');
                    var speed = read(pa + 'speed') == 'true' ? true : false;
                    if (speed) 
                        var ppp = [];
                    while (read(pa + 'hp') > 0 && hp > 0 && po == read(pa + 'place')) {
                        var de = hh.defence;
                        var at = hh.attack;
                        var DE = items[read(pa + 'defence')].defence;
                        var AT = Math.ceil(items[read(pa + 'attack')].damage + 2 + (read(pa + 'level') * 1.35));
                        AT -= de;
                        var per = Math.random() * 5 | 0;
                        if (per == 1) {
                            var ff = sender + ' 님의 크리티컬!';
                            if (speed) 
                                ppp.push(ff);
                            else 
                                replier.reply(ff);
                            AT *= 3;
                        }
                        hp -= AT;
                        var f = sender + ' ➵ ' + msg + '\n\nHP: ' + hp;
                        if (speed) 
                            ppp.push(f + '\n\n\n');
                        else 
                            replier.reply(f);
                        if (hp <= 0) {
                            var reword = hh.rewords.Random();
                            var num = (Math.random() * 5 | 0) + 1;
                            Give(image, reword, num);
                            write(pa + 'xp', Number(read(pa + 'xp')) + Number(hh.xp));
                            replier.reply(re + msg + ' 몬스터를 사냥했습니다!\n\n[ 전리품 ]\n' + reword + '\xd7' + num + '\n' + hh.xp + ' EXP');
                            var qqq = read(path + 'map/info/' + po + '/monsters').split('​');
                            let place = read(pa + 'place');
                            setTimeout(() => {
    let nowp = read(pa + 'place');
    if (place == nowp) 
        write(path + 'map/info/' + po + '/monsters', read(path + 'map/info/' + po + '/monsters') + '​' + msg);
}, 120000);
                            qqq.splice(qqq.indexOf(msg), 1);
                            write(path + 'map/info/' + po + '/monsters', qqq.join('​'));
                            if (+read(pa + 'xp') >= +read(pa + 'up')) {
                                write(pa + 'level', Number(read(pa + 'level')) + 1);
                                write(pa + 'up', read(pa + 'up') * 2);
                                write(pa + 'xp', 1);
                                write(pa + 'maxhp', Math.round(read(pa + 'maxhp') * 1.3));
                                write(pa + 'maxmana', Math.round(read(pa + 'maxmana') * 1.3));
                                write(pa + 'hp', read(pa + 'maxhp'));
                                write(pa + 'mana', read(pa + 'maxmana'));
                                write(pa + 'money', Math.round(+read(pa + 'money') + +read(pa + 'level') * Math.random()));
                                replier.reply(re + '레벨 업!');
                            }
                            if (speed) 
                                replier.reply(re + '[ 빠른 전투 결과입니다 ]\n' + all + '\n\n' + ppp.join('\n'));
                            return;
                        }
                        if (!speed) {
                            java.lang.Thread.sleep(2000);
                        }
                        at -= DE;
                        var per = Math.random() * 10 | 0;
                        if (per == 1) {
                            var ff = msg + ' 몬스터의 크리티컬!';
                            if (speed) 
                                ppp.push(ff);
                            else 
                                replier.reply(ff);
                            at *= 3;
                        }
                        write(pa + 'hp', read(pa + 'hp') - at);
                        var f = msg + ' ➵ ' + sender + '\n\nHP: ' + read(pa + 'hp');
                        if (speed) 
                            ppp.push(f + '\n\n\n');
                        else 
                            replier.reply(f);
                        if (!speed) {
                            java.lang.Thread.sleep(1500);
                        }
                    }
                    if (speed) 
                        replier.reply(re + '[ 빠른 전투 결과입니다 ]\n' + all + '\n\n' + ppp.join('\n'));
                }
            }
            if (read(pa + 'maxhp') < read(pa + 'hp')) 
                write(pa + 'hp', read(pa + 'maxhp'));
            if (+read(pa + 'maxmana') < +read(pa + 'mana')) 
                write(pa + 'mana', read(pa + 'maxmana'));
        }
    }  catch (e) {
    replier.reply('잘못된 명령입니다.');
}
};
