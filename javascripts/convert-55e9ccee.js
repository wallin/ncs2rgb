!function(){var r,n,e,a=[].slice;n=/^(\d{2})(\d{2})\-([bgryn])(\S*)/i,e=/(\d{2})([bgry])/i,r={r:0,y:60,g:120,b:240},window.parseNcs=function(r){var a,t,o,s,i,c,u,d,h,l;if(r=r.toLowerCase(),!(i=r.toLowerCase().match(n)))throw"Invalid NCS";if(h=i.slice(1),d=h[0],u=h[1],o=h[2],c=h[3],c){if(!(t=c.match(e)))throw"Invalid NCS";l=t.slice(1),a=l[0],s=l[1]}return[parseInt(d,10),parseInt(u,10),o,parseInt(a,10),s]},window.ncs2string=function(r){var n;return n=[zeroPad(r[0]),zeroPad(r[1]),"-",r[2].toUpperCase()],null!=r[3]&&null!=r[4]&&n.push(zeroPad(r[3]),r[4].toUpperCase()),n.join("")},window.ncs2hsv=function(n){var e,a,t,o,s,i;return i=parseNcs(n),s=i[0],o=i[1],a=i[2],e=i[3],t=i[4],"n"===a&&(o=0),s=100-s,a&&t?(e=parseInt(e,10)/100,a=r[a],t=r[t],e=Math.round(a*e+t*(1-e))):e="n"!==a?r[a]:0,[e,o,s]},window.hsv2rgb=function(r,n,e){var a,t,o,s,i,c,u,d;switch(r/=360,n/=100,e/=100,s=Math.floor(6*r),t=6*r-s,i=e*(1-n),c=e*(1-t*n),d=e*(1-(1-t)*n),s%6){case 0:u=e,o=d,a=i;break;case 1:u=c,o=e,a=i;break;case 2:u=i,o=e,a=d;break;case 3:u=i,o=c,a=e;break;case 4:u=d,o=i,a=e;break;case 5:u=e,o=i,a=c}return[Math.round(255*u),Math.round(255*o),Math.round(255*a)]},window.zeroPad=function(r){return r+="",1===r.length?"0"+r:""+r},window.dec2hex=function(){var r,n,e,t,o;for(n=1<=arguments.length?a.call(arguments,0):[],o=[],e=0,t=n.length;t>e;e++)r=n[e],o.push(zeroPad(r.toString(16)));return o}}.call(this);