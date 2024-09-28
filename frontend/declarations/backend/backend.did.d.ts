import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';
import type { IDL } from '@dfinity/candid';

export interface _SERVICE {
  'getGrid' : ActorMethod<[], Array<Array<bigint>>>,
  'getMoves' : ActorMethod<[], bigint>,
  'isSolved' : ActorMethod<[], boolean>,
  'makeMove' : ActorMethod<[bigint, bigint], boolean>,
  'newGame' : ActorMethod<[], Array<Array<bigint>>>,
}
export declare const idlFactory: IDL.InterfaceFactory;
export declare const init: (args: { IDL: typeof IDL }) => IDL.Type[];
