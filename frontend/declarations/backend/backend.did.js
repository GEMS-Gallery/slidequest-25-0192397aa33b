export const idlFactory = ({ IDL }) => {
  return IDL.Service({
    'getGrid' : IDL.Func([], [IDL.Vec(IDL.Vec(IDL.Nat))], ['query']),
    'getMoves' : IDL.Func([], [IDL.Nat], ['query']),
    'isSolved' : IDL.Func([], [IDL.Bool], ['query']),
    'makeMove' : IDL.Func([IDL.Nat, IDL.Nat], [IDL.Bool], []),
    'newGame' : IDL.Func([], [IDL.Vec(IDL.Vec(IDL.Nat))], []),
  });
};
export const init = ({ IDL }) => { return []; };
