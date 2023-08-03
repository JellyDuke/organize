let busJson = "";
var xhr = new XMLHttpRequest();
var url = 'http://apis.data.go.kr/1613000/BusLcInfoInqireService/getRouteAcctoBusLcList'; /*URL*/
var queryParams = '?' + encodeURIComponent('serviceKey') + '='+'서비스키'; /*Service Key*/
queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1'); /**/
queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('10'); /**/
queryParams += '&' + encodeURIComponent('_type') + '=' + encodeURIComponent('xml'); /**/
queryParams += '&' + encodeURIComponent('cityCode') + '=' + encodeURIComponent('25'); /**/
queryParams += '&' + encodeURIComponent('routeId') + '=' + encodeURIComponent('DJB30300052'); /**/
xhr.open('GET', url + queryParams);
xhr.onreadystatechange = function () {
    if (this.readyState == 4) {  
      alert('Status: '+this.status+'nHeaders: '+JSON.stringify(this.getAllResponseHeaders())+'nBody: '+this.responseText);
      busJson = JSON.stringify(this.getAllResponseHeaders())
      console.log(busJson);
    }
};

xhr.send('');

