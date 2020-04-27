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
  addConfigRow('S', gen.config.sset.join(' '));
  addConfigRow('L', gen.config.lset.join(' '));
  addConfigRow('F', gen.config.fset.join(' '));
  addConfigRow('Syllable Structure', gen.config.syllable_structure);
  addConfigRow('Phrase Structure', gen.config.phrase_structure);
  addConfigRow('min syllables in word', gen.config.word_length_min);
  addConfigRow('max syllables in word', gen.config.word_length_max);


  document.getElementById('langname').innerHTML =
    `The language of ${ languagename }`;


  let wordTable = document.getElementById('words');

  wordTable.innerHTML = '<thead><th>Word</th><th>Meaning</th></thead>';

  function addWordRow(orig, trans) {
    let row = document.createElement('tr');
    let origEl = document.createElement('td');
    origEl.innerText = orig;
    let transEl = document.createElement('td');
    transEl.innerText = trans;

    row.append(origEl);
    row.append(transEl);

    wordTable.append(row);
  }

  for(let i = 0; i < colors.length; i++) {
    addWordRow(gen.createWord(colors[i]), colors[i]);
  }

  for(let i = 0; i < landmarks.length; i++) {
    addWordRow(gen.createWord(landmarks[i]), landmarks[i]);
  }

  for(let i = 0; i < adjectives.length; i++) {
    addWordRow(gen.createWord(adjectives[i]), adjectives[i]);
  }

  var phraseTable = document.getElementById('phrases');
  phraseTable.innerHTML = '<thead><th>Phrases</th><th>Translated</th></thead>';
  function addPhrase(orig) {
    var row = document.createElement('tr');
    phraseTable.append(row);

    var configName = document.createElement('td');
    configName.innerText = orig;
    var configValue = document.createElement('td');
    const foo = gen.translate(orig);
    console.log('WHAT', foo);
    configValue.innerText = Object.values(foo.h).join(' ');
    row.append(configName);
    row.append(configValue);
  }

  for(var i = 0; i < 10; i++) {
    var place =gen.random.choice(landmarks);
    addPhrase(gen.createPhrase(place));
  }
}

generate();
