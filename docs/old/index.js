const urlParams = new URLSearchParams(window.location.search);
const seedParam = urlParams.get('seed');

function createSeed() {
  var newSeed = Math.round(Math.random() * 100000000000);
  urlParams.set('seed', newSeed);
  window.location.search = urlParams;
}

function generate(seed) {
  let gen = new Language(null, seed);
  let languagename = gen.createWord('language');

  document.getElementById(
    'langname'
  ).innerHTML = `The language of ${languagename}`;

  var configtable = document.getElementById('config');
  configtable.innerHTML = '<thead><th>Config</th><th></th></thead>';

  const addConfigRow = (name, data, tooltip) =>
    addTableRow(configtable, 2, { name, data }, tooltip);

  addConfigRow('Vowels', gen.config.vowels.join(' '));
  addConfigRow('Consonants', gen.config.consonants.join(' '));
  addConfigRow('Sibilants', gen.config.sibilants.join(' '));
  addConfigRow('Liquids', gen.config.liquids.join(' '));
  addConfigRow('Finals', gen.config.finals.join(' '));
  addConfigRow(
    'Syllable Structure',
    gen.config.syllable_structure,
    tooltips.syllable_structure
  );
  addConfigRow(
    'Phrase Structure',
    gen.config.phrase_structure,
    tooltips.phrase_structure
  );
  addConfigRow('min syllables in word', gen.config.word_length_min);
  addConfigRow('max syllables in word', gen.config.word_length_max);

  var rewritetable = document.getElementById('rewrite');
  rewritetable.innerHTML =
    '<thead><th>char</th><th>rule</th><th>Replace With</th></thead>';

  const addRewriteRow = (char, rule, replaceWith) =>
    addTableRow(rewritetable, 3, { char, rule, replaceWith });

  gen.config.rewriteset.forEach((r) =>
    addRewriteRow(r.character, r.rule, r.replaceWith)
  );

  var orthoTable = document.getElementById('ortho');
  orthoTable.innerHTML = '<thead><th>Phoneme</th><th>Written</th></thead>';

  const addOrthoRow = (letter, ortho) =>
    addTableRow(orthoTable, 2, { letter, ortho });

  var letters = gen.config.vowels
    .concat(gen.config.consonants)
    .concat(gen.config.sibilants)
    .concat(gen.config.liquids)
    .concat(gen.config.finals)
    .reduce((a, b) => {
      if (a.indexOf(b) === -1) {
        a.push(b);
      }

      return a;
    }, []);

  for (let i = 0; i < letters.length; i++) {
    addOrthoRow(letters[i], gen.spell.spell(letters[i]));
  }

  let wordTable = document.getElementById('words');
  wordTable.innerHTML = '<thead><th>Word</th><th>Meaning</th></thead>';

  const addWordRow = (word, trans, ipa) =>
    addTableRow(wordTable, 3, { word, trans, ipa });

  console.log('wee', gen);

  for (let i = 0; i < colors.length; i++) {
    gen.createWord(colors[i]);
  }

  for (let i = 0; i < landmarks.length; i++) {
    gen.createWord(landmarks[i]);
  }

  for (let i = 0; i < adjectives.length; i++) {
    gen.createWord(adjectives[i]);
  }

  let words = Object.entries(gen.trans_words.h);
  let words_ipa = Object.entries(gen.words_ipa.h);
  for (let i = 0; i < words.length; i++) {
    let url = `http://ipa-reader.xyz/?text=${words_ipa[i][1]}&voice=Joanna`;
    let ipa_link = `<a href="${url}" target="_blank">${words_ipa[i][1]}</a>`;
    addWordRow(words[i][0], words[i][1], ipa_link);
  }

  var phraseEl = document.getElementById('phrases');
  phraseEl.innerHTML = '';

  for (var i = 0; i < 9; i++) {
    var place = gen.random.choice(landmarks);
    const phrase = gen.createPhrase(place);
    let row = "<div class='phrase'>";
    phrase.split(' ').map((p) => {
      const trans = Object.values(gen.translate(p).h).join('.');
      row += `
      <ruby>${p}<rt>${trans}</rt></ruby>
      `;
    });

    phraseEl.innerHTML += row;
    phraseEl.innerHTML += '</div>';
  }
}

if (!seedParam) {
  createSeed();
}

generate(seedParam);
