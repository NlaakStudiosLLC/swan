# GWF Squares (sqrz) Module

[Home](../README.md) | [GWF Chain](./gwf.md) | [Profiles](./profile.md) | [Blogger](./blog.md) | [Squares](./sqrz.md) | [Fund Me](./fund.md)

## Overview

The `sqrz` module is a Cosmos SDK module that implements the GWF Squares (sqrz) module for the GWF blockchain.
Basically you are able to post a square image on the blockchain for other users to see. All squares are HD images (1920x1920) and have up to five (5) tags that describe the image. The tags are used to search for squares. The tags are also used to generate a unique hash for the square. The hash is used to identify the square.

    - JPG 100% 24bit/pixel 752.72KB
    - PNG lossless 24bit/pixel 2.14MB

### Module Parameters

| Name         | Type   | Default | Description                                        |
| ------------ | ------ | ------- | -------------------------------------------------- |
| `enabled`    | `bool` | true    | Used to Enable or Disable the module.              |
| `costperday` | `int`  | 0       | The amount of GWF to charge for each day of a post |
| `finebase`   | `int`  | 0       | The amount of GWF to charge for each offense       |
| `divisor`    | `int`  | 1000    | The amount to divide costperday and finebase by    |

## Square Properties

- Creator: The address of the creator of the square.
- Tags: The tags that describe the square. (5 max)
- Image: The image of the square. (1920x1920) (max 4MB)
- Hash: The hash of the square. (sha256)
- Views: The number of times the square has been viewed.
- Likes: The number of times the square has been liked.
- Dislikes: The number of times the square has been disliked.
- Popularity: The popularity of the square. (likes - dislikes)
- esrb: The ESRB rating of the square. (E, E10+, T, M, AO)

### Scaffold the Sqrz Module (All In One Cmd)

    ignite scaffold module sqrz square guid:string tags:array.string image:string hash:string views:int likes:int dislikes:int popularity:int esrb:string --params enabled:bool,costperday:uint,finebase:uint,divisor:uint,finescalarpct:uint --dep account,bank

### Scaffold the Params

Params are values that
can be set at the genesis of the blockchain and can be modified while the
blockchain is running.

| Param Name    | Type | Description                                         |
| ------------- | ---- | --------------------------------------------------- |
| enabled       | bool | Allows enabling & disabling the module when needed  |
| divisor       | uint | Value to divide costperday and finebase by. ie 1000 |
| costperday    | uint | Cost per day (in GWF Tokens) for post               |
| finebase      | uint | first offense fine amount (in GWF Tokens)           |
| finescalarpct | uint | fine amount increase per offense (in %)             |

    ignite scaffold module sqrz --params enabled:bool,costperday:uint,finebase:uint,divisor:uint,finescalarpct:uint

 Your saved project changes have not been committed. To enable reverting to your current state, commit your saved changes. Do you want to proceed without committing your saved changes: 
No
➜  io.gwf.chain git:(feat/add-sqrz-module) ✗ ignite scaffold module sqrz --params enabled:bool,costperday:uint,finebase:uint,divisor:uint,finescalarpct:uint

    modify app/app.go
    create proto/gwf/sqrz/genesis.proto
    create proto/gwf/sqrz/params.proto
    create proto/gwf/sqrz/query.proto
    create proto/gwf/sqrz/tx.proto
    create testutil/keeper/sqrz.go
    create x/sqrz/client/cli/query.go
    create x/sqrz/client/cli/query_params.go
    create x/sqrz/client/cli/tx.go
    create x/sqrz/genesis.go
    create x/sqrz/genesis_test.go
    create x/sqrz/keeper/grpc_query.go
    create x/sqrz/keeper/grpc_query_params.go
    create x/sqrz/keeper/grpc_query_params_test.go
    create x/sqrz/keeper/keeper.go
    create x/sqrz/keeper/msg_server.go
    create x/sqrz/keeper/msg_server_test.go
    create x/sqrz/keeper/params.go
    create x/sqrz/keeper/params_test.go
    create x/sqrz/module.go
    create x/sqrz/module_simulation.go
    create x/sqrz/simulation/helpers.go
    create x/sqrz/types/codec.go
    create x/sqrz/types/errors.go
    create x/sqrz/types/expected_keepers.go
    create x/sqrz/types/genesis.go
    create x/sqrz/types/genesis_test.go
    create x/sqrz/types/keys.go
    create x/sqrz/types/params.go
    create x/sqrz/types/types.go

    🎉 Module created sqrz.

### Scaffold the Map (CRUD)

    ignite scaffold map square guid:string tags:array.string image:string hash:string views:int likes:int dislikes:int popularity:int esrb:string --module sqrz

    modify proto/gwf/sqrz/genesis.proto
    modify proto/gwf/sqrz/query.proto
    create proto/gwf/sqrz/square.proto
    modify proto/gwf/sqrz/tx.proto
    modify x/sqrz/client/cli/query.go
    create x/sqrz/client/cli/query_square.go
    create x/sqrz/client/cli/query_square_test.go
    modify x/sqrz/client/cli/tx.go
    create x/sqrz/client/cli/tx_square.go
    create x/sqrz/client/cli/tx_square_test.go
    modify x/sqrz/genesis.go
    modify x/sqrz/genesis_test.go
    create x/sqrz/keeper/grpc_query_square.go
    create x/sqrz/keeper/grpc_query_square_test.go
    create x/sqrz/keeper/msg_server_square.go
    create x/sqrz/keeper/msg_server_square_test.go
    create x/sqrz/keeper/square.go
    create x/sqrz/keeper/square_test.go
    modify x/sqrz/module_simulation.go
    create x/sqrz/simulation/square.go
    modify x/sqrz/types/codec.go
    modify x/sqrz/types/genesis.go
    modify x/sqrz/types/genesis_test.go
    create x/sqrz/types/key_square.go
    create x/sqrz/types/messages_square.go
    create x/sqrz/types/messages_square_test.go

    🎉 square added.

### Scaffold the module

Empty module

    ignite scaffold module sqrz

    modify app/app.go
    create proto/gwfchain/sqrz/genesis.proto
    create proto/gwfchain/sqrz/params.proto
    create proto/gwfchain/sqrz/query.proto
    create proto/gwfchain/sqrz/tx.proto
    create testutil/keeper/sqrz.go
    create x/sqrz/client/cli/query.go
    create x/sqrz/client/cli/query_params.go
    create x/sqrz/client/cli/tx.go
    create x/sqrz/genesis.go
    create x/sqrz/genesis_test.go
    create x/sqrz/keeper/grpc_query.go
    create x/sqrz/keeper/grpc_query_params.go
    create x/sqrz/keeper/grpc_query_params_test.go
    create x/sqrz/keeper/keeper.go
    create x/sqrz/keeper/msg_server.go
    create x/sqrz/keeper/msg_server_test.go
    create x/sqrz/keeper/params.go
    create x/sqrz/keeper/params_test.go
    create x/sqrz/module.go
    create x/sqrz/module_simulation.go
    create x/sqrz/simulation/helpers.go
    create x/sqrz/types/codec.go
    create x/sqrz/types/errors.go
    create x/sqrz/types/expected_keepers.go
    create x/sqrz/types/genesis.go
    create x/sqrz/types/genesis_test.go
    create x/sqrz/types/keys.go
    create x/sqrz/types/params.go
    create x/sqrz/types/types.go

    🎉 Module created sqrz.

    ignite scaffold module sqrz square guid:string tags:array.string image:string hash:string views:int likes:int dislikes:int popularity:int esrb:string --params enabled:bool,costperday:uint,finebase:uint,divisor:uint,finescalarpct:uint --dep account,bank

    ignite scaffold message createSquare tags image hash likes dislikes popularity esrb reports --module sqrz --desc "CreateSquare creates a new square."

    ignite scaffold message createSquare tags image hash likes dislikes popularity esrb reports --module sqrz --desc "CreateSquare creates a new square."

    modify proto/iogwfchain/sqrz/tx.proto
    modify x/sqrz/client/cli/tx.go
    create x/sqrz/client/cli/tx_create_square.go
    create x/sqrz/keeper/msg_server_create_square.go
    modify x/sqrz/module_simulation.go
    create x/sqrz/simulation/create_square.go
    modify x/sqrz/types/codec.go
    create x/sqrz/types/message_create_square.go
    create x/sqrz/types/message_create_square_test.go

    🎉 Created a message `createSquare`.

### Scaffold the type 

    ignite scaffold type Square tags:array.string image:string hash:string views:int likes:int dislikes:int popularity:int esrb:string --module sqrz



    type Square struct {
        Creator sdk.AccAddress `json:"creator" yaml:"creator"`
        Tags    []string       `json:"tags" yaml:"tags"`
        Image   []byte         `json:"image" yaml:"image"`
        Hash    string         `json:"hash" yaml:"hash"`
        Views   int64          `json:"views" yaml:"views"`
        Likes   int64          `json:"likes" yaml:"likes"`
        Dislikes int64         `json:"dislikes" yaml:"dislikes"`
        Popularity int64       `json:"popularity" yaml:"popularity"`
        ESRB    string         `json:"esrb" yaml:"esrb"`
    }

```proto
message Square {
  string creator = 1;
  repeated string tags = 2;
  bytes image = 3;
  string hash = 4;
  int64 views = 5;
  int64 likes = 6;
  int64 dislikes = 7;
  int64 popularity = 8;
  string esrb = 9;
}
```

## ESRB Ratings

- E: Everyone
- E10+: Everyone 10+
- T: Teen
- M: Mature
- AO: Adults Only

## Messages

### MsgCreateSquare

`MsgCreateSquare` is a message that creates a new square.

```go
type MsgCreateSquare struct {
    Creator sdk.AccAddress `json:"creator" yaml:"creator"`
    Tags    []string       `json:"tags" yaml:"tags"`
    Image   []byte         `json:"image" yaml:"image"`
    ESRB    string         `json:"esrb" yaml:"esrb"`
}
```

### MsgUpdateSquare

`MsgUpdateSquare` is a message that updates an existing square.

```go
type MsgUpdateSquare struct {
    Creator sdk.AccAddress `json:"creator" yaml:"creator"`
    ID      string         `json:"id" yaml:"id"`
    Tags    []string       `json:"tags" yaml:"tags"`
    Image   []byte         `json:"image" yaml:"image"`
    ESRB    string         `json:"esrb" yaml:"esrb"`
}
```

### MsgDeleteSquare

`MsgDeleteSquare` is a message that deletes an existing square.

```go
type MsgDeleteSquare struct {
    Creator sdk.AccAddress `json:"creator" yaml:"creator"`
    ID      string         `json:"id" yaml:"id"`
}
```

### MsgLikeSquare

`MsgLikeSquare` is a message that likes an existing square.

```go
type MsgLikeSquare struct {
    Creator sdk.AccAddress `json:"creator" yaml:"creator"`
    ID      string         `json:"id" yaml:"id"`
}
```

### MsgDislikeSquare

`MsgDislikeSquare` is a message that dislikes an existing square.

```go
type MsgDislikeSquare struct {
    Creator sdk.AccAddress `json:"creator" yaml:"creator"`
    ID      string         `json:"id" yaml:"id"`
}
```

### MsgViewSquare

`MsgViewSquare` is a message that views an existing square.

```go
type MsgViewSquare struct {
    Creator sdk.AccAddress `json:"creator" yaml:"creator"`
    ID      string         `json:"id" yaml:"id"`
}
```

### MsgCreateReport

`MsgCreateReport` is a message that creates a new report/complaint for community review.

```go
type MsgCreateReport struct {
    Creator sdk.AccAddress `json:"creator" yaml:"creator"`
    ID      string         `json:"id" yaml:"id"`
    Reason  string         `json:"reason" yaml:"reason"`
}
```

## Endpoints

### QuerySquare

`QuerySquare` returns a square based on the hash.

```go
func (k Keeper) QuerySquare(ctx sdk.Context, hash string) (types.Square, error) {
    store := prefix.NewStore(ctx.KVStore(k.storeKey), types.KeyPrefix(types.SquareKey))
    var square types.Square
    k.cdc.MustUnmarshalBinaryBare(store.Get(types.KeyPrefix(hash)), &square)
    return square, nil
}
```

### QueryAllSquare

`QueryAllSquare` returns all square.

```go
func (k Keeper) QueryAllSquare(ctx sdk.Context) ([]types.Square, error) {
    var squares []types.Square
    store := prefix.NewStore(ctx.KVStore(k.storeKey), types.KeyPrefix(types.SquareKey))
    iterator := sdk.KVStorePrefixIterator(store, []byte{})
    for ; iterator.Valid(); iterator.Next() {
        var square types.Square
        k.cdc.MustUnmarshalBinaryBare(iterator.Value(), &square)
        squares = append(squares, square)
    }
    return squares, nil
}
```

### QueryReport

`QueryReport` returns a report based on the hash.

```go
func (k Keeper) QueryReport(ctx sdk.Context, hash string) (types.Report, error) {
    store := prefix.NewStore(ctx.KVStore(k.storeKey), types.KeyPrefix(types.ReportKey))
    var report types.Report
    k.cdc.MustUnmarshalBinaryBare(store.Get(types.KeyPrefix(hash)), &report)
    return report, nil
}
```

### QueryAllReport

`QueryAllReport` returns all report.

```go
func (k Keeper) QueryAllReport(ctx sdk.Context) ([]types.Report, error) {
    var reports []types.Report
    store := prefix.NewStore(ctx.KVStore(k.storeKey), types.KeyPrefix(types.ReportKey))
    iterator := sdk.KVStorePrefixIterator(store, []byte{})
    for ; iterator.Valid(); iterator.Next() {
        var report types.Report
        k.cdc.MustUnmarshalBinaryBare(iterator.Value(), &report)
        reports = append(reports, report)
    }
    return reports, nil
}
```

### QuerySquareCount

`QuerySquareCount` returns the total number of squares.

```go
func (k Keeper) QuerySquareCount(ctx sdk.Context) int64 {
    store := prefix.NewStore(ctx.KVStore(k.storeKey), types.KeyPrefix(types.SquareCountKey))
    byteKey := types.KeyPrefix(types.SquareCountKey)
    b := store.Get(byteKey)
    if b == nil {
        return 0
    }
    return sdk.BigEndianToUint64(b)
}
```

### QueryReportCount

`QueryReportCount` returns the total number of reports.

```go
func (k Keeper) QueryReportCount(ctx sdk.Context) int64 {
    store := prefix.NewStore(ctx.KVStore(k.storeKey), types.KeyPrefix(types.ReportCountKey))
    byteKey := types.KeyPrefix(types.ReportCountKey)
    b := store.Get(byteKey)
    if b == nil {
        return 0
    }
    return sdk.BigEndianToUint64(b)
}
```

### QuerySquareActiveCount

`QuerySquareActiveCount` returns the total number of active squares.

```go
func (k Keeper) QuerySquareActiveCount(ctx sdk.Context) int64 {
    store := prefix.NewStore(ctx.KVStore(k.storeKey), types.KeyPrefix(types.SquareActiveCountKey))
    byteKey := types.KeyPrefix(types.SquareActiveCountKey)
    b := store.Get(byteKey)
    if b == nil {
        return 0
    }
    return sdk.BigEndianToUint64(b)
}
```
