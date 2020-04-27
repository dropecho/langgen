const {Language} = require('./langgen');

var gen = new Language();

console.log(gen.config);

var colors = [
  'blue',
  'yellow',
  'purple',
  'white',
  'black',
  'green',
];

var landmarks = [
  'city',
  'river',
  'bay',
  'harbor',
  'mountain',
  'plains',
  'hills'
];

var adjectives = [
  'great',
  'shining',
  'dark',
  'heavenly',
  'haunted'
];

// console.log('test', test);

var ct = [];
for(var c in colors) {
  var word = gen.createWord(c);
  ct.push(word);
  console.log(colors[c], word);
}

var tland= [];
for(var w in landmarks) {
  var word = gen.createWord(w);
  tland.push(word);
  console.log(landmarks[w], word);
}

var tadj = [];
for(var a in adjectives) {
  var word = gen.createWord(a);
  tadj.push(word);
  console.log(adjectives[a], word);
}
