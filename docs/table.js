function generateTooltip() {
  const tooltip = document.createElement('div');

  tooltip.innerText = 'TOOLTIP BOIS';
  tooltip.classList.add('tooltip');

  return tooltip;
}

function addTableRow(table, colCount, data) {
  const row = document.createElement('tr');
  // configtable.append(row);

  console.log('wee', data);
  for (let i = 0; i < colCount; i++) {
    const val = Object.values(data)[i];
    const el = document.createElement('td');
    el.innerHTML = val;
    row.append(el);
  }

  row.append(generateTooltip());
  table.append(row);
}
