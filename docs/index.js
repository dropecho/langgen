function generate(){
  let gen = new Language();

  let colors = [
    'blue',
    'yellow',
    'purple',
    'white',
    'black',
    'green',
  ];

  let landmarks = [
    'city',
    'river',
    'bay',
    'harbor',
    'mountain',
    'plains',
    'hills'
  ];

  let adjectives = [
    'great',
    'shining',
    'dark',
    'heavenly',
    'haunted'
  ];

  let languagename = gen.createWord('language');

  console.log(gen.config);

  var configtable = document.getElementById('config');
  configtable.innerHTML = '<thead><th>Config</th><th></th></thead>';


  function addConfigRow(name, data) {
    var row = document.createElement('tr');
    configtable.append(row);

    var configName = document.createElement('td');
    configName.innerText = name;
    var configValue = document.createElement('td');
    configValue.innerText = data;
    row.append(configName);
    row.append(configValue);
  }

  addConfigRow('Vowels', gen.config.vowels.join(' '));
  addConfigRow('Consonants', gen.config.consonants.join(' '));
  addConfigRow('Syllable Structure', gen.config.syllable_structure);


  document.getElementById('langname').innerHTML =
    `The language of ${ languagename }`;


  let wordTable = document.getElementById('words');

  wordTable.innerHTML = '<thead><th>Word</th><th>Meaning</th></thead>';

  let ct = [];
  for(let c in colors) {
    let word = gen.createWord(colors[c]);
    ct.push(word);
    let row = document.createElement('tr');
    let orig = document.createElement('td');
    orig.innerText = colors[c];
    let trans = document.createElement('td');
    trans.innerText=word;

    row.append(trans);
    row.append(orig);

    wordTable.append(row);
  }

  let tland= [];
  for(let w in landmarks) {
    let word = gen.createWord(landmarks[w]);
    tland.push(word);
    let row = document.createElement('tr');
    let orig = document.createElement('td');
    orig.innerText = landmarks[w];
    let trans = document.createElement('td');
    trans.innerText=word;

    row.append(trans);
    row.append(orig);

    wordTable.append(row);
  }

  let tadj = [];
  for(let a in adjectives) {
    let word = gen.createWord(adjectives[a]);
    tadj.push(word);
    let row = document.createElement('tr');
    let orig = document.createElement('td');
    orig.innerText = adjectives[a];
    let trans = document.createElement('td');
    trans.innerText=word;

    row.append(trans);
    row.append(orig);

    wordTable.append(row);
  }

}

generate();
