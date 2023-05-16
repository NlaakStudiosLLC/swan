# GWF Profile (prof) Module

[Home](../README.md) | [GWF Chain](./gwf.md) | [Profiles](./profile.md) | [Blogger](./blog.md) | [Squares](./sqrz.md) | [Fund Me](./fund.md)

## Overview

This module implements a profile page for users. Not only does it let the user set their profile but they can set different access/visibility levels and privacy settings. This is also where users can see all available modules and enable/disable them.

### Module Parameters

| Name      | Type   | Default | Description                           |
| --------- | ------ | ------- | ------------------------------------- |
| `enabled` | `bool` | true    | Used to Enable or Disable the module. |

### Profile Properties

| Name         | Type           | Default   | Description                      |
| ------------ | -------------- | --------- | -------------------------------- |
| `username`   | `string`       | ""        | The username of the user.        |
| `bio`        | `string`       | ""        | The bio of the user.             |
| `avatar`     | `bytes`        | ""        | The avatar of the user.          |
| `cover`      | `string`       | "{url}"   | The cover of the user.           |
| `theme`      | `string`       | "default" | The theme of the user.           |
| `visibility` | `string`       | "private" | The visibility of the user.      |
| `groups`     | `array.string` | []        | The groups enabled by the user.  |
| `modules`    | `array.string` | []        | The modules enabled by the user. |

#### Account Breakdown & Summary

As stated on our [project page](https://landing.gwf.io) our `Core Values` are

- Privacy: Simple control over whom sees what
- Security: You own your keys, therefore your content
- Versatility: Modules allow infinite expansion
- Performance: Lighting fast blockchain (10 sec)
- Sustainability: Official Validators instead of Miners (energy/cost savings).

The best way to see how we go about doing this is to take a look and an example master account file.

### Current Configurable properties

These are provided by the `User` object

- Username -> Your unique username (Required)
- avatar -> the CID of your avatar on GWFStorage
- Status -> your current status (online, away, dnd, etc)
- Name -> your real name
- Email -> your email address
- Mobile -> your mobile phone number
- Sex -> [M]ale, [F]emale, [U]ndefined (Default)
- Gender -> Full LGBTQ+ support
- Country -> your country code ie. [US]
- Bio -> short text, anything you desire
- FollowingCount -> Number of accounts your following (in progress)
- FollowAccounts -> The list of accounts you are following (in progress)
- FollowerCount -> Number of accounts your following you (in progress)
- FollowerAccounts -> The list of accounts that are following you (in progress)

Please note that everything defaults to `Private`. You must add accounts to the groups and choose which properties to make visible for each group. You can see an example of this in the Account JSON above.

### Share Groups

GWF Smartchain uses what we call `share groups` to give the user simple and total control over
<u>who can view what content</u>. At this time we just have these basic properties available

#### Available Share Groups

- 0 Private         (DEFAULT) only owner has full access
- 1 Family          Accounts in this group can view allowed content
- 2 Friends         Accounts in this group can view allowed content
- 3 Coworkers       Accounts in this group can view allowed content
- 4 Followers       Accounts in this group can view allowed content
- 5 Denied          Accounts in this group cannot view any content
- 6 Public          Anyone can view allowed content

All of this happens on-chain. All encryption and decryption happen on-chain storing/retrieving content. So everything
stored on GWFStorage (IPFS/Filecoin) is 100% secured for each individual user

In the app, you will be able to very easily configure your share groups. There are two (2) steps that must be done.

- First, configure each shared groups properties. These are Checkboxes for all properties which are `unchecked` by default. `Check` the properties you want <u>this</u> group to view.
- Second, add users to each `share group`. Under each group, you can add a user via

  1. Magic URL Link via Mobile Text Message (Enter Phone #)
  2. Magic URL Link via Email (Enter Email)
  3. Scan QR Code
  4. Enter User Account Address Manually

Let's say you have a coworker who becomes a good friend. You simply move their account address from the `Coworker` group to the `Friends` group. There is also a `Denied` group where you can place any accounts that you do not wish to have access to any of your content.

#### Why go through so much trouble?

We believe that the user owns their content and should have any amount of privacy that they desire. We also extend this
to cryptocurrencies on our DEX. No one should know what you are buying, selling or holding in your wallet. Your Defi wallet is a separate account only visible to you. You cannot expose it to your `Share Groups`. We do not believe that governments should have permission to monitor and tax you at this point. When you move your crypto to a government fiat currency, then the laws and taxes applicable to the fiat should be applied.

So, the answer to the question is simple. If `WE` as an entity providing you with service cannot decrypt and see the content - then a <u>supena is worthless</u>.

## Types

### Proto3

```proto
message Profile {
  string username = 1;
  string bio = 2;
  bytes avatar = 3;
  string cover = 4;
  string theme = 5;
  repeated string visibility = 6;
  repeated string groups = 7;
  repeated string modules = 8;
}
```

### Golang

```go
type Profile struct {
  Username   string   `json:"username"`
  Bio        string   `json:"bio"`
  Avatar     []byte   `json:"avatar"`
  Cover      string   `json:"cover"`
  Theme      string   `json:"theme"`
  Visibility []string `json:"visibility"`
  Groups     []string `json:"groups"`
  Modules    []string `json:"modules"`
}
```

## Scaffolding

### Module

  ignite scaffold module profile --params enabled:bool --dep account,bank --yes

  modify app/app.go
  create proto/gwfchain/profile/genesis.proto
  create proto/gwfchain/profile/params.proto
  create proto/gwfchain/profile/query.proto
  create proto/gwfchain/profile/tx.proto
  create testutil/keeper/profile.go
  create x/profile/client/cli/query.go
  create x/profile/client/cli/query_params.go
  create x/profile/client/cli/tx.go
  create x/profile/genesis.go
  create x/profile/genesis_test.go
  create x/profile/keeper/grpc_query.go
  create x/profile/keeper/grpc_query_params.go
  create x/profile/keeper/grpc_query_params_test.go
  create x/profile/keeper/keeper.go
  create x/profile/keeper/msg_server.go
  create x/profile/keeper/msg_server_test.go
  create x/profile/keeper/params.go
  create x/profile/keeper/params_test.go
  create x/profile/module.go
  create x/profile/module_simulation.go
  create x/profile/simulation/helpers.go
  create x/profile/types/codec.go
  create x/profile/types/errors.go
  create x/profile/types/expected_keepers.go
  create x/profile/types/genesis.go
  create x/profile/types/genesis_test.go
  create x/profile/types/keys.go
  create x/profile/types/params.go
  create x/profile/types/types.go

  🎉 Module created profile.
### Messages

  ignite scaffold message createProfile --module profile --yes

  modify proto/gwfchain/profile/tx.proto
  modify x/profile/client/cli/tx.go
  create x/profile/client/cli/tx_create_profile.go
  create x/profile/keeper/msg_server_create_profile.go
  modify x/profile/module_simulation.go
  create x/profile/simulation/create_profile.go
  modify x/profile/types/codec.go
  create x/profile/types/message_create_profile.go
  create x/profile/types/message_create_profile_test.go

  🎉 Created a message `createProfile`.

  ignite scaffold message updateProfile --module profile --yes

  modify proto/gwfchain/profile/tx.proto
  modify x/profile/client/cli/tx.go
  create x/profile/client/cli/tx_update_profile.go
  create x/profile/keeper/msg_server_update_profile.go
  modify x/profile/module_simulation.go
  create x/profile/simulation/update_profile.go
  modify x/profile/types/codec.go
  create x/profile/types/message_update_profile.go
  create x/profile/types/message_update_profile_test.go

  🎉 Created a message `updateProfile`.

  ignite scaffold message deleteProfile --module profile --yes

  modify proto/gwfchain/profile/tx.proto
  modify x/profile/client/cli/tx.go
  create x/profile/client/cli/tx_delete_profile.go
  create x/profile/keeper/msg_server_delete_profile.go
  modify x/profile/module_simulation.go
  create x/profile/simulation/delete_profile.go
  modify x/profile/types/codec.go
  create x/profile/types/message_delete_profile.go
  create x/profile/types/message_delete_profile_test.go

  🎉 Created a message `deleteProfile`.

### Queries

  ignite scaffold query getProfile --module profile --yes

  modify proto/gwfchain/profile/query.proto
  modify x/profile/client/cli/query.go
  create x/profile/client/cli/query_get_profile.go
  create x/profile/keeper/grpc_query_get_profile.go

  🎉 Created a query `getProfile`.
