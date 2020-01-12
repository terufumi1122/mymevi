const array = [
  {id: 1, n: 1, m: 2},
  {id: 2, n: 1, m: 3},
  {id: 3, n: 1, m: 2},
];

array;

const newArray = array.filter(item => 
  !(item.n === 1 && item.m === 2)
); 

array;
newArray;