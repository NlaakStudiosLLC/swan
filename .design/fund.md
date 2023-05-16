# GWF Fund Me (fund) Module

[Home](../README.md) | [GWF Chain](./gwf.md) | [Profiles](./profile.md) | [Blogger](./blog.md) | [Squares](./sqrz.md) | [Fund Me](./fund.md)

## Overview

This module allows users to transfer assets via a escrow based model so that they never have any details about each other.

### Module Parameters

| Name             | Type   | Default | Description                                        |
| ---------------- | ------ | ------- | -------------------------------------------------- |
| `enabled`        | `bool` | true    | Used to Enable or Disable the fund module.         |
| `min_fee`        | `int`  | 1       | The minimum fee percentage a fulfiller can charge. |
| `max_fee`        | `int`  | 25      | The maximum fee percentage a fulfiller can charge. |
| `order_lifespan` | `int`  | 24      | The maximum number of hours the order will exist.  |

### High level flow

1. User A creates a fund request, called an Order, for desired amount of a certain asset. For example: 1000 GWF
2. The fund module creates a escrow account for the fund request that is only accessible by the fund module and is only used for this fund request.
3. User B (a fulfiller) can then fund the Order by sending the desired amount of the asset to the escrow account with their fee percentage. Multiple fulfillers can fund the same Order.
4. User A can then cancel the Order at any time before it is fully funded. This will send the desired amount of the asset back to the creator of the Order and the fees to the fulfillers.
5. User A can also select multiple fulfillers to fulfill the order. This will send the desired amount of the asset to User A and the fees to the fulfillers.
6. Upon completion of the Order, the escrow account is destroyed.

### Scenarios

#### Single fulfiller

1. User A creates an Order for 1000 GWF with a maximum fee of 10%.
2. Fulfiller B sends 1000 GWF to the escrow account with a fee of 5%.
3. User A accepts the Fulfiller B's Order.
4. 950 GWF is sent to User A and 50 GWF is sent to Fulfiller B and the escrow account is destroyed.

#### Multiple fulfillers

1. User A creates an Order for 100000 GWF with a maximum fee of 2%.
2. Fulfiller B sends 1000 GWF to the escrow account with a fee of 3%.
3. Fulfiller C sends 7500 GWF to the escrow account with a fee of 2%.
4. Fulfiller D sends 50000 GWF to the escrow account with a fee of 1%.
5. Fulfiller E sends 10000 GWF to the escrow account with a fee of 1%.
6. Fulfiller F sends 11500 GWF to the escrow account with a fee of 2%.
7. Fulfiller G sends 20000 GWF to the escrow account with a fee of 1%.
8. User A accepts the Order and the order is completed.
9. Fulfiller B gets sent 30 GWF (3% of 1000 GWF)
10. Fulfiller C gets sent 150 GWF (2% of 7500 GWF)
11. Fulfiller D gets sent 500 GWF (1% of 50000 GWF)
12. Fulfiller E gets sent 100 GWF (1% of 10000 GWF)
13. Fulfiller F gets sent 230 GWF (2% of 11500 GWF)
14. Fulfiller G gets sent 200 GWF (1% of 20000 GWF)
15. The remaining GWF (98,790) is sent to User A.
16. The escrow account is destroyed.

## Scaffolding

```sh
ignite scaffold module fund --params enabled:bool,min_fee:int,max_fee:int,order_lifespan:int --dep account,bank --yes
```

```sh
modify app/app.go
create proto/gwfchain/fund/genesis.proto
create proto/gwfchain/fund/params.proto
create proto/gwfchain/fund/query.proto
create proto/gwfchain/fund/tx.proto
create testutil/keeper/fund.go
create x/fund/client/cli/query.go
create x/fund/client/cli/query_params.go
create x/fund/client/cli/tx.go
create x/fund/genesis.go
create x/fund/genesis_test.go
create x/fund/keeper/grpc_query.go
create x/fund/keeper/grpc_query_params.go
create x/fund/keeper/grpc_query_params_test.go
create x/fund/keeper/keeper.go
create x/fund/keeper/msg_server.go
create x/fund/keeper/msg_server_test.go
create x/fund/keeper/params.go
create x/fund/keeper/params_test.go
create x/fund/module.go
create x/fund/module_simulation.go
create x/fund/simulation/helpers.go
create x/fund/types/codec.go
create x/fund/types/errors.go
create x/fund/types/expected_keepers.go
create x/fund/types/genesis.go
create x/fund/types/genesis_test.go
create x/fund/types/keys.go
create x/fund/types/params.go
create x/fund/types/types.go

🎉 Module created fund.
```

```sh
# User A creates a fund request, called an Order, for desired amount of a certain asset. For example: 1000 GWF
ignite scaffold message createFundOrder amount:int asset:string fee:int --module fund --yes
```

```sh
modify proto/gwfchain/fund/tx.proto
modify x/fund/client/cli/tx.go
create x/fund/client/cli/tx_create_fund_order.go
create x/fund/keeper/msg_server_create_fund_order.go
modify x/fund/module_simulation.go
create x/fund/simulation/create_fund_order.go
modify x/fund/types/codec.go
create x/fund/types/message_create_fund_order.go
create x/fund/types/message_create_fund_order_test.go

🎉 Created a message `createFundOrder`.
```

```sh
# User B (a fulfiller) can then fund the Order by sending the desired amount of the asset to the escrow account with their fee percentage. Multiple fulfillers can fund the same Order.
ignite scaffold message fillFundOrder order_id:int amount:int asset:string fee:int --module fund --yes
```

```sh
modify proto/gwfchain/fund/tx.proto
modify x/fund/client/cli/tx.go
create x/fund/client/cli/tx_fill_fund_order.go
create x/fund/keeper/msg_server_fill_fund_order.go
modify x/fund/module_simulation.go
create x/fund/simulation/fill_fund_order.go
modify x/fund/types/codec.go
create x/fund/types/message_fill_fund_order.go
create x/fund/types/message_fill_fund_order_test.go

🎉 Created a message `fillFundOrder`.
```

```sh
# User A can also select multiple fulfillers to fulfill the order. This will send the desired amount of the asset to User A and the fees to the fulfillers.
ignite scaffold message acceptFundOrder order_id:int fulfiller:string --module fund --yes
```

```sh
modify proto/gwfchain/fund/tx.proto
modify x/fund/client/cli/tx.go
create x/fund/client/cli/tx_accept_fund_order.go
create x/fund/keeper/msg_server_accept_fund_order.go
modify x/fund/module_simulation.go
create x/fund/simulation/accept_fund_order.go
modify x/fund/types/codec.go
create x/fund/types/message_accept_fund_order.go
create x/fund/types/message_accept_fund_order_test.go

🎉 Created a message `acceptFundOrder`.
```

```sh
# User A can then cancel the Order at any time before it is fully funded. This will send the desired amount of the asset back to the creator of the Order and the fees to the fulfillers.
ignite scaffold message cancelFundOrder order_id:int --module fund --yes
```

```sh
modify proto/gwfchain/fund/tx.proto
modify x/fund/client/cli/tx.go
create x/fund/client/cli/tx_cancel_fund_order.go
create x/fund/keeper/msg_server_cancel_fund_order.go
modify x/fund/module_simulation.go
create x/fund/simulation/cancel_fund_order.go
modify x/fund/types/codec.go
create x/fund/types/message_cancel_fund_order.go
create x/fund/types/message_cancel_fund_order_test.go

🎉 Created a message `cancelFundOrder`.
```

```sh
ignite scaffold query orders --response order_id,creator,amount,asset,fee,fulfillers,created_at,completed_at --module fund --yes
```

```sh
modify proto/gwfchain/fund/query.proto
modify x/fund/client/cli/query.go
create x/fund/client/cli/query_orders.go
create x/fund/keeper/grpc_query_orders.go

🎉 Created a query `orders`.
```

```sh
ignite scaffold query order order_id:int --response order_id,creator,amount,asset,fee,fulfillers,created_at,completed_at --module fund --yes
```

```sh
modify proto/gwfchain/fund/query.proto
modify x/fund/client/cli/query.go
create x/fund/client/cli/query_order.go
create x/fund/keeper/grpc_query_order.go

🎉 Created a query `order`.
```

### Testing

```sh
gwfchaind tx fund create-fund-order 1000 GWF 10 --from alice
```

```sh
gwfchaind tx fund fund-order 1 1000 GWF 5 --from bob
```

```sh
gwfchaind tx fund accept-fund-order 1 bob --from alice
```

```sh
gwfchaind tx fund cancel-fund-order 1 --from alice
```

```sh
gwfchaind query fund orders
```

```sh
gwfchaind query fund order 1
```
## Types

### Proto3

```proto
message Order {
  int64 order_id = 1;
  string creator = 2;
  int64 amount = 3;
  string asset = 4;
  int64 fee = 5;
  repeated string fulfillers = 6;
  google.protobuf.Timestamp created_at = 7;
  google.protobuf.Timestamp completed_at = 8;
}
```

### Golang

```go
type Order struct {
  OrderID    int64     `json:"order_id" yaml:"order_id"`
  Creator    string    `json:"creator" yaml:"creator"`
  Amount     int64     `json:"amount" yaml:"amount"`
  Asset      string    `json:"asset" yaml:"asset"`
  Fee        int64     `json:"fee" yaml:"fee"`
  Fulfillers []string  `json:"fulfillers" yaml:"fulfillers"`
  CreatedAt  time.Time `json:"created_at" yaml:"created_at"`
  CompletedAt time.Time `json:"completed_at" yaml:"completed_at"`
}
```

## Messages

### CreateFundOrder

| Name    | Type   | Description                                                                 |
| ------- | ------ | --------------------------------------------------------------------------- |
| `amount` | `int`  | The amount of the asset to be transferred.                                  |
| `asset`  | `string` | The asset to be transferred.                                                |
| `fee`    | `int`  | The maximum fee percentage a fulfiller can charge.                          |

### FundOrder

| Name    | Type   | Description                                                                 |
| ------- | ------ | --------------------------------------------------------------------------- |
| `order_id` | `int`  | The ID of the Order.                                                        |
| `amount` | `int`  | The amount of the asset to be transferred.                                  |
| `asset`  | `string` | The asset to be transferred.                                                |
| `fee`    | `int`  | The fee percentage the fulfiller is charging.                               |

### AcceptFundOrder

| Name    | Type   | Description                                                                 |
| ------- | ------ | --------------------------------------------------------------------------- |
| `order_id` | `int`  | The ID of the Order.                                                        |
| `fulfiller` | `string` | The address of the fulfiller.                                               |

### CancelFundOrder

| Name    | Type   | Description                                                                 |
| ------- | ------ | --------------------------------------------------------------------------- |
| `order_id` | `int`  | The ID of the Order.                                                        |

## Queries

### Orders

| Name    | Type   | Description                                                                 |
| ------- | ------ | --------------------------------------------------------------------------- |
| `order_id` | `int`  | The ID of the Order.                                                        |
| `creator` | `string` | The address of the creator of the Order.                                    |
| `amount` | `int`  | The amount of the asset to be transferred.                                  |
| `asset`  | `string` | The asset to be transferred.                                                |
| `fee`    | `int`  | The maximum fee percentage a fulfiller can charge.                          |
| `fulfillers` | `[]string` | The addresses of the fulfillers.                                            |
| `created_at` | `int`  | The timestamp of when the Order was created.                                |
| `completed_at` | `int`  | The timestamp of when the Order was completed.                              |

### Order

| Name           | Type       | Description                                        |
| -------------- | ---------- | -------------------------------------------------- |
| `order_id`     | `int`      | The ID of the Order.                               |
| `creator`      | `string`   | The address of the creator of the Order.           |
| `amount`       | `int`      | The amount of the asset to be transferred.         |
| `asset`        | `string`   | The asset to be transferred.                       |
| `fee`          | `int`      | The maximum fee percentage a fulfiller can charge. |
| `fulfillers`   | `[]string` | The addresses of the fulfillers.                   |
| `created_at`   | `int`      | The timestamp of when the Order was created.       |
| `completed_at` | `int`      | The timestamp of when the Order was completed.     |

## Events

### FundOrderCreated

| Name         | Type       | Description                                        |
| ------------ | ---------- | -------------------------------------------------- |
| `order_id`   | `int`      | The ID of the Order.                               |
| `creator`    | `string`   | The address of the creator of the Order.           |
| `amount`     | `int`      | The amount of the asset to be transferred.         |
| `asset`      | `string`   | The asset to be transferred.                       |
| `fee`        | `int`      | The maximum fee percentage a fulfiller can charge. |
| `fulfillers` | `[]string` | The addresses of the fulfillers.                   |
| `created_at` | `int`      | The timestamp of when the Order was created.       |

### FundOrderFunded

| Name         | Type     | Description                                                                 |
| ------------ | -------- | --------------------------------------------------------------------------- |
| `order_id`   | `int`    | The ID of the Order.                                                        |
| `fulfiller`  | `string` | The address of the fulfiller.                                               |
| `amount`     | `int`    | The amount of the asset to be transferred.                                  |
| `asset`      | `string` | The asset to be transferred.                                                |
| `fee`        | `int`    | The fee percentage the fulfiller is charging.                               |
| `created_at` | `int`    | The timestamp of when the Order was created.                                |

### FundOrderAccepted

| Name         | Type     | Description                                                                 |
| ------------ | -------- | --------------------------------------------------------------------------- |
| `order_id`   | `int`    | The ID of the Order.                                                        |
| `fulfiller`  | `string` | The address of the fulfiller.                                               |
| `amount`     | `int`    | The amount of the asset to be transferred.                                  |
| `asset`      | `string` | The asset to be transferred.                                                |
| `fee`        | `int`    | The fee percentage the fulfiller is charging.                               |
| `created_at` | `int`    | The timestamp of when the Order was created.                                |

### FundOrderCancelled

| Name         | Type       | Description                                                                 |
| ------------ | ---------- | --------------------------------------------------------------------------- |
| `order_id`   | `int`      | The ID of the Order.                                                        |
| `creator`    | `string`   | The address of the creator of the Order.                                    |
| `amount`     | `int`      | The amount of the asset to be transferred.                                  |
| `asset`      | `string`   | The asset to be transferred.                                                |
| `fee`        | `int`      | The maximum fee percentage a fulfiller can charge.                          |
| `fulfillers` | `[]string` | The addresses of the fulfillers.                                            |
| `created_at` | `int`      | The timestamp of when the Order was created.                                |

### FundOrderCompleted

| Name           | Type     | Description                                                                 |
| -------------- | -------- | --------------------------------------------------------------------------- |
| `order_id`     | `int`    | The ID of the Order.                                                        |
| `creator`      | `string` | The address of the creator of the Order.                                    |
| `fulfiller`    | `string` | The address of the fulfiller.                                               |
| `amount`       | `int`    | The amount of the asset to be transferred.                                  |
| `asset`        | `string` | The asset to be transferred.                                                |
| `fee`          | `int`    | The fee percentage the fulfiller is charging.                               |
| `created_at`   | `int`    | The timestamp of when the Order was created.                                |
| `completed_at` | `int`    | The timestamp of when the Order was completed.                              |

## Example

### Create an Order

```javascript
const order = await client.createOrder({
  amount: 100,
  asset: 'BTC',
  fee: 5,
  fulfillers: ['0x1234...']
})
```

### Fund an Order

```javascript
const order = await client.fundOrder({
  order_id: 1,
  fulfiller: '0x1234...'
})
```

### Accept an Order

```javascript
const order = await client.acceptOrder({
  order_id: 1,
  fulfiller: '0x1234...'
})
```

### Cancel an Order

```javascript
const order = await client.cancelOrder({
  order_id: 1
})
```

### Complete an Order

```javascript
const order = await client.completeOrder({
  order_id: 1,
  fulfiller: '0x1234...'
})
```

### Get an Order

```javascript
const order = await client.getOrder({
  order_id: 1
})
```

### Get Orders

```javascript
const orders = await client.getOrders()
```






## DeFi Fund module
As a rapidly growing industry in the blockchain ecosystem, (decentralized finance) DeFi is spurring innovation and revolution in spending, sending, locking, and funding cryptocurrency tokens.

One of the many goals of blockchain is to make financial instruments available to everyone. A fund in blockchain DeFi can be used in combination with funding, lending, borrowing, spot trading, margin trading, and flash funds.

With DeFi, end users can quickly and easily access assets without having to submit their passports or background checks like in the traditional banking system.


### Intial Steps

- Scaffold a blockchain
- Scaffold a Cosmos SDK fund module
- Scaffold a list for fund objects
- Create messages in the fund module to interact with the fund object
- Interact with other Cosmos SDK modules
- Use an escrow module account
- Add application messages for a fund system
- Request fund
- Approve fund
- Repay fund
- Liquidate fund
- Cancel fund

> Note: The code in this tutorial is written specifically for this learning experience and is intended only for educational purposes. This tutorial code is not intended to be used in production.

### Module design
A fund consists of:

An id

The amount that is being lent

A fee as cost for the fund

The borrowing party provides a collateral to request a fund

A fund has a deadline for repayment, after which the fund can be liquidated

A fund has a state that describes the status as:

requested
approved
paid
cancelled
liquidated
The two accounts involved in the fund are:

requester
fulfiller
The requester
A requester posts a fund request with fund information such as:

amount
fee
collateral
deadline
The requester must repay the fund amount and the fund fee to the fulfiller by the deadline risk losing the collateral.

The fulfiller
A fulfiller can approve a fund request from a requester.

After the fulfiller approves the fund, the fund amount is transferred to the requester.
If the requester is unable to pay the fund, the fulfiller can liquidate the fund.
Fund liquidation transfers the collateral and the fees to the fulfiller.