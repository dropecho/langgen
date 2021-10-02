function generateTooltip(content) {
  const tooltip = document.createElement('div');

  tooltip.innerText = content || '';
  tooltip.classList.add('tooltip');

  var icon = document.createElement('i');
  tooltip.appendChild(icon);

  return tooltip;
}

function addTableRow(table, colCount, data, tooltip) {
  const row = document.createElement('tr');

  console.log('wee', data);
  for (let i = 0; i < colCount; i++) {
    const val = Object.values(data)[i];
    const el = document.createElement('td');
    el.innerHTML = val;
    row.append(el);
  }

  if (tooltip) {
    row.append(generateTooltip(tooltip));
  }
  table.append(row);
}
