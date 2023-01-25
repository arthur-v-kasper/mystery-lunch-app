function getLastSixMonths() {
  const date = new Date();
  const months = [];
  for (let i = 0; i < 6; i++) {
    const year = date.getFullYear();
    let month = date.getMonth() + 1;
    month = month < 10 ? `0${month}` : month;
    const key = `${year}${month}`;
    months.push(parseInt(key));
    date.setMonth(date.getMonth() - 1);
  }
  return months;
}
