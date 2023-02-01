// export function getLastSixMonths() {
//   const date = new Date();
//   const months = [];
//   for (let i = 0; i < 6; i++) {
//     const year = date.getFullYear();
//     let month = date.getMonth() + 1;
//     month = month < 10 ? `0${month}` : month;
//     const key = `${year}${month}`;
//     months.push(key);
//     date.setMonth(date.getMonth() - 1);
//   }
//   return months;
// }

export function getLastSixMonths() {
  let currentMonth = new Date().getMonth();
  let currentYear = new Date().getFullYear();
  let result = [];
  for (let i = 0; i < 6; i++) {
    let year = currentYear;
    let month = currentMonth - i;
    if (month < 0) {
      year--;
      month = 12 + month;
    }
    result.push(`${year}${("0" + (month + 1)).slice(-2)}`);
  }
  return result;
}
