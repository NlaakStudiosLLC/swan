# Ignite Documentation

## Scaffolding

Scaffolding is a quick way to generate code for major pieces of your
application.

For details on each scaffolding target (chain, module, message, etc.) run the
corresponding command with a "--help" flag, for example, "ignite scaffold chain
--help".

The Ignite team strongly recommends committing the code to a version control
system before running scaffolding commands. This will make it easier to see the
changes to the source code as well as undo the command if you've decided to roll
back the changes.

This blockchain you create with the chain scaffolding command uses the modular
Cosmos SDK framework and imports many standard modules for functionality like
proof of stake, token transfer, inter-blockchain connectivity, governance, and
more. Custom functionality is implemented in modules located by convention in
the "x/" directory. By default, your blockchain comes with an empty custom
module. Use the module scaffolding command to create an additional module.

An empty custom module doesn't do much, it's basically a container for logic
that is responsible for processing transactions and changing the application
state. Cosmos SDK blockchains work by processing user-submitted signed
transactions, which contain one or more messages. A message contains data that
describes a state transition. A module can be responsible for handling any
number of messages.

A message scaffolding command will generate the code for handling a new type of
Cosmos SDK message. Message fields describe the state transition that the
message is intended to produce if processed without errors.

Scaffolding messages is useful to create individual "actions" that your module
can perform. Sometimes, however, you want your blockchain to have the
functionality to create, read, update and delete (CRUD) instances of a
particular type. Depending on how you want to store the data there are three
commands that scaffold CRUD functionality for a type: list, map, and single.
These commands create four messages (one for each CRUD action), and the logic to
add, delete, and fetch the data from the store. If you want to scaffold only the
logic, for example, you've decided to scaffold messages separately, you can do
that as well with the "--no-message" flag.

Reading data from a blockchain happens with a help of queries. Similar to how
you can scaffold messages to write data, you can scaffold queries to read the
data back from your blockchain application.

You can also scaffold a type, which just produces a new protocol buffer file
with a proto message description. Note that proto messages produce (and
correspond with) Go types whereas Cosmos SDK messages correspond to proto "rpc"
in the "Msg" service.

If you're building an application with custom IBC logic, you might need to
scaffold IBC packets. An IBC packet represents the data sent from one blockchain
to another. You can only scaffold IBC packets in IBC-enabled modules scaffolded
with an "--ibc" flag. Note that the default module is not IBC-enabled.

```
chain       Fully-featured Cosmos SDK blockchain
module      Scaffold a Cosmos SDK module
list        CRUD for data stored as an array
map         CRUD for data stored as key-value pairs
single      CRUD for data stored in a single location
type        Scaffold only a type definition
message     Message to perform state transition on the blockchain
query       Query to get data from the blockchain
packet      Message for sending an IBC packet
band        Scaffold an IBC BandChain query oracle to request real-time data
```

### Chain

Create a new application-specific Cosmos SDK blockchain.

For example, the following command will create a blockchain called "hello" in
the "hello/" directory:

```sh
ignite scaffold chain hello
```

A project name can be a simple name or a URL. The name will be used as the Go
module path for the project. Examples of project names:

```sh
ignite scaffold chain foo
ignite scaffold chain foo/bar
ignite scaffold chain example.org/foo
ignite scaffold chain github.com/username/foo
```

A new directory with source code files will be created in the current directory.
To use a different path use the "--path" flag.

Most of the logic of your blockchain is written in custom modules. Each module
effectively encapsulates an independent piece of functionality. Following the
Cosmos SDK convention, custom modules are stored inside the "x/" directory. By
default, Ignite creates a module with a name that matches the name of the
project. To create a blockchain without a default module use the "--no-module"
flag. Additional modules can be added after a project is created with "ignite
scaffold module" command.

Account addresses on Cosmos SDK-based blockchains have string prefixes. For
example, the Cosmos Hub blockchain uses the default "cosmos" prefix, so that
addresses look like this: "cosmos12fjzdtqfrrve7zyg9sv8j25azw2ua6tvu07ypf". To
use a custom address prefix use the "--address-prefix" flag. For example:

```sh
ignite scaffold chain foo --address-prefix bar
```

By default when compiling a blockchain's source code Ignite creates a cache to
speed up the build process. To clear the cache when building a blockchain use
the "--clear-cache" flag. It is very unlikely you will ever need to use this
flag.

The blockchain is using the Cosmos SDK modular blockchain framework. Learn more
about Cosmos SDK on https://docs.cosmos.network

```
Usage:
  ignite scaffold chain [name] [flags]

Flags:
      --address-prefix string   Account address prefix (default "cosmos")
      --clear-cache             clear the build cache (advanced)
  -h, --help                    help for chain
      --no-module               Create a project without a default module
  -p, --path string             Create a project in a specific path (default ".")
```

#### Chain Namespace

Commands in this namespace let you to build, initialize, and start your
blockchain node locally for development purposes.

To run these commands you should be inside the project's directory so that
Ignite can find the source code. To ensure that you are, run "ls", you should
see the following files in the output: "go.mod", "x", "proto", "app", etc.

##### build (Build a node binary)

By default the "build" command will identify the "main" package of the project,
install dependencies if necessary, set build flags, compile the project into a
binary and install the binary. The "build" command is useful if you just want
the compiled binary, for example, to initialize and start the chain manually. It
can also be used to release your chain's binaries automatically as part of
continuous integration workflow.

##### init (Initialize your chain)

The "init" command will build the chain's binary and use it to initialize a
local validator node. By default the validator node will be initialized in your
$HOME directory in a hidden directory that matches the name of your project.
This directory is called a data directory and contains a chain's genesis file
and a validator key. This command is useful if you want to quickly build and
initialize the data directory and use the chain's binary to manually start the
blockchain. The "init" command is meant only for development purposes, not
production.

##### serve (Start a blockchain node in development)

The "serve" command builds, initializes, and starts your blockchain locally with
a single validator node for development purposes. "serve" also watches the
source code directory for file changes and intelligently
re-builds/initializes/starts the chain, essentially providing "code-reloading".
The "serve" command is meant only for development purposes, not production.

To distinguish between production and development consider the following.

In production, blockchains often run the same software on many validator nodes
that are run by different people and entities. To launch a blockchain in
production, the validator entities coordinate the launch process to start their
nodes simultaneously.

During development, a blockchain can be started locally on a single validator
node. This convenient process lets you restart a chain quickly and iterate
faster. Starting a chain on a single node in development is similar to starting
a traditional web application on a local server.

##### faucet (Send coins to an account)

The "faucet" command lets you send tokens to an address from the "faucet"
account defined in "config.yml". Alternatively, you can use the chain's binary
to send token from any other account that exists on chain.

##### simulate (Run simulation testing for the blockchain)

The "simulate" command helps you start a simulation testing process for your
chain.

Usage:
  ignite chain [command]

Aliases:
  chain, c

Available Commands:
  serve       Start a blockchain node in development
  build       Build a node binary
  init        Initialize your chain
  faucet      Send coins to an account
  simulate    Run simulation testing for the blockchain

Flags:
  -c, --config string   ignite config file (default: ./config.yml)
  -h, --help            help for chain
  -y, --yes             answers interactive yes/no questions with yes

Use "ignite chain [command] --help" for more information about a command.

### Module

Scaffold a new Cosmos SDK module.

Cosmos SDK is a modular framework and each independent piece of functionality is
implemented in a separate module. By default your blockchain imports a set of
standard Cosmos SDK modules. To implement custom functionality of your
blockchain, scaffold a module and implement the logic of your application.

#### This command does the following:

* Creates a directory with module's protocol buffer files in "proto/"
* Creates a directory with module's boilerplate Go code in "x/"
* Imports the newly created module by modifying "app/app.go"
* Creates a file in "testutil/keeper/" that contains logic to create a keeper
  for testing purposes

This command will proceed with module scaffolding even if "app/app.go" doesn't
have the required default placeholders. If the placeholders are missing, you
will need to modify "app/app.go" manually to import the module. If you want the
command to fail if it can't import the module, use the "--require-registration"
flag.

#### IBC Enabled Modules

To scaffold an IBC-enabled module use the "--ibc" flag. An IBC-enabled module is
like a regular module with the addition of IBC-specific logic and placeholders
to scaffold IBC packets with "ignite scaffold packet".

#### Other Modules

A module can depend on one or more other modules and import their keeper
methods. To scaffold a module with a dependency use the "--dep" flag

For example, your new custom module "foo" might have functionality that requires
sending tokens between accounts. The method for sending tokens is a defined in
the "bank"'s module keeper. You can scaffold a "foo" module with the dependency
on "bank" with the following command:

```sh
ignite scaffold module foo --dep bank
```

You can then define which methods you want to import from the "bank" keeper in
"expected_keepers.go".

You can also scaffold a module with a list of dependencies that can include both
standard and custom modules (provided they exist):

```sh
ignite scaffold module bar --dep foo,mint,account
```

Note: the "--dep" flag doesn't install third-party modules into your
application, it just generates extra code that specifies which existing modules
your new custom module depends on.

A Cosmos SDK module can have parameters (or "params"). Params are values that
can be set at the genesis of the blockchain and can be modified while the
blockchain is running. An example of a param is "Inflation rate change" of the
"mint" module. A module can be scaffolded with params using the "--params" flag
that accepts a list of param names. By default params are of type "string", but
you can specify a type for each param. For example:

```sh
ignite scaffold module foo --params baz:uint,bar:bool
```

Refer to Cosmos SDK documentation to learn more about modules, dependencies and
params.

```
Usage:
  ignite scaffold module [name] [flags]

Flags:
      --clear-cache            clear the build cache (advanced)
      --dep strings            module dependencies (e.g. --dep account,bank)
  -h, --help                   help for module
      --ibc                    scaffold an IBC module
      --ordering string        channel ordering of the IBC module [none|ordered|unordered] (default "none")
      --params strings         scaffold module params
  -p, --path string            path of the app (default ".")
      --require-registration   if true command will fail if module can't be registered
  -y, --yes                    answers interactive yes/no questions with yes

  ### List
```

  The "list" scaffolding command is used to generate files that implement the
logic for storing and interacting with data stored as a list in the blockchain
state.

The command accepts a NAME argument that will be used as the name of a new type
of data. It also accepts a list of FIELDs that describe the type.

The interaction with the data follows the create, read, updated, and delete
(CRUD) pattern. For each type three Cosmos SDK messages are defined for writing
data to the blockchain: MsgCreate{Name}, MsgUpdate{Name}, MsgDelete{Name}. For
reading data two queries are defined: {Name} and {Name}All. The type, messages,
and queries are defined in the "proto/" directory as protocol buffer messages.
Messages and queries are mounted in the "Msg" and "Query" services respectively.

When messages are handled, the appropriate keeper methods are called. By
convention, the methods are defined in
"x/{moduleName}/keeper/msg_server_{name}.go". Helpful methods for getting,
setting, removing, and appending are defined in the same "keeper" package in
"{name}.go".

The "list" command essentially allows you to define a new type of data and
provides the logic to create, read, update, and delete instances of the type.
For example, let's review a command that generates the code to handle a list of
posts and each post has "title" and "body" fields:

```sh
ignite scaffold list post title body
```

This provides you with a "Post" type, MsgCreatePost, MsgUpdatePost,
MsgDeletePost and two queries: Post and PostAll. The compiled CLI, let's say the
binary is "blogd" and the module is "blog", has commands to query the chain (see
"blogd q blog") and broadcast transactions with the messages above (see "blogd
tx blog").

The code generated with the list command is meant to be edited and tailored to
your application needs. Consider the code to be a "skeleton" for the actual
business logic you will implement next.

By default, all fields are assumed to be strings. If you want a field of a
different type, you can specify it after a colon ":". The following types are
supported: string, bool, int, uint, coin, array.string, array.int, array.uint,
array.coin. An example of using custom types:

```sh
ignite scaffold list pool amount:coin tags:array.string height:int
```

Ignite also supports custom types:

```sh
ignite scaffold list product-details name description

ignite scaffold list product price:coin details:ProductDetails
```

In the example above the "ProductDetails" type was defined first, and then used
as a custom type for the "details" field. Ignite doesn't support arrays of
custom types yet.

By default the code will be scaffolded in the module that matches your project's
name. If you have several modules in your project, you might want to specify a
different module:

```sh
ignite scaffold list post title body --module blog
```

By default, each message comes with a "creator" field that represents the
address of the transaction signer. You can customize the name of this field with
a flag:

```sh
ignite scaffold list post title body --signer author
```

It's possible to scaffold just the getter/setter logic without the CRUD
messages. This is useful when you want the methods to handle a type, but would
like to scaffold messages manually. Use a flag to skip message scaffolding:

```sh
ignite scaffold list post title body --no-message
```

The "creator" field is not generated if a list is scaffolded with the
"--no-message" flag.

```
Usage:
  ignite scaffold list NAME [field]... [flags]

Flags:
      --clear-cache     clear the build cache (advanced)
  -h, --help            help for list
      --module string   Module to add into. Default is app's main module
      --no-message      Disable CRUD interaction messages scaffolding
      --no-simulation   Disable CRUD simulation scaffolding
  -p, --path string     path of the app (default ".")
      --signer string   Label for the message signer (default: creator)
  -y, --yes             answers interactive yes/no questions with yes

  ### Map
```

  The "map" scaffolding command is used to generate files that implement the logic
for storing and interacting with data stored as key-value pairs (or a
dictionary) in the blockchain state.

The "map" command is very similar to "ignite scaffold list" with the main
difference in how values are indexed. With "list" values are indexed by an
incrementing integer, whereas "list" values are indexed by a user-provided value
(or multiple values).

Let's use the same blog post example:

  ignite scaffold map post title body

This command scaffolds a "Post" type and CRUD functionality to create, read,
updated, and delete posts. However, when creating a new post with your chain's
binary (or by submitting a transaction through the chain's API) you will be
required to provide an "index":

  blogd tx blog create-post [index] [title] [body]
        blogd tx blog create-post hello "My first post" "This is the body"

This command will create a post and store it in the blockchain's state under the
"hello" index. You will be able to fetch back the value of the post by querying
for the "hello" key.

  blogd q blog show-post hello

To customize the index, use the "--index" flag. Multiple indices can be
provided, which simplifies querying values. For example:

  ignite scaffold map product price desc --index category,guid

With this command, you would get a "Product" value indexed by both a category
and a GUID (globally unique ID). This will let you programmatically fetch
product values that have the same category but are using different GUIDs.

Since the behavior of "list" and "map" scaffolding is very similar, you can use
the "--no-message", "--module", "--signer" flags as well as the colon syntax for
custom types.

Usage:
  ignite scaffold map NAME [field]... [flags]

Flags:
      --clear-cache     clear the build cache (advanced)
  -h, --help            help for map
      --index strings   fields that index the value (default [index])
      --module string   Module to add into. Default is app's main module
      --no-message      Disable CRUD interaction messages scaffolding
      --no-simulation   Disable CRUD simulation scaffolding
  -p, --path string     path of the app (default ".")
      --signer string   Label for the message signer (default: creator)
  -y, --yes             answers interactive yes/no questions with yes

### Single

CRUD for data stored in a single location

Usage:
  ignite scaffold single NAME [field]... [flags]

Flags:
      --clear-cache     clear the build cache (advanced)
  -h, --help            help for single
      --module string   Module to add into. Default is app's main module
      --no-message      Disable CRUD interaction messages scaffolding
      --no-simulation   Disable CRUD simulation scaffolding
  -p, --path string     path of the app (default ".")
      --signer string   Label for the message signer (default: creator)
  -y, --yes             answers interactive yes/no questions with yes

### Type

Scaffold only a type definition

| Type         | Alias   | Index | Code Type | Description                     |
|--------------|---------|-------|-----------|---------------------------------|
| string       | -       | yes   | string    | Text type                       |
| array.string | strings | no    | []string  | List of text type               |
| bool         | -       | yes   | bool      | Boolean type                    |
| int          | -       | yes   | int32     | Integer type                    |
| array.int    | ints    | no    | []int32   | List of integers types          |
| uint         | -       | yes   | uint64    | Unsigned integer type           |
| array.uint   | uints   | no    | []uint64  | List of unsigned integers types |
| coin         | -       | no    | sdk.Coin  | Cosmos SDK coin type            |
| array.coin   | coins   | no    | sdk.Coins | List of Cosmos SDK coin types   |

Usage:
  ignite scaffold type NAME [field]... [flags]

Flags:
      --clear-cache     clear the build cache (advanced)
  -h, --help            help for type
      --module string   Module to add into. Default is app's main module
      --no-message      Disable CRUD interaction messages scaffolding
      --no-simulation   Disable CRUD simulation scaffolding
  -p, --path string     path of the app (default ".")
      --signer string   Label for the message signer (default: creator)
  -y, --yes             answers interactive yes/no questions with yes

### Message 

Message scaffolding is useful for quickly adding functionality to your
blockchain to handle specific Cosmos SDK messages.

Messages are objects whose end goal is to trigger state transitions on the
blockchain. A message is a container for fields of data that affect how the
blockchain's state will change. You can think of messages as "actions" that a
user can perform.

For example, the bank module has a "Send" message for token transfers between
accounts. The send message has three fields: from address (sender), to address
(recipient), and a token amount. When this message is successfully processed,
the token amount will be deducted from the sender's account and added to the
recipient's account.

Ignite's message scaffolding lets you create new types of messages and add them
to your chain. For example:

  ignite scaffold message add-pool amount:coins denom active:bool --module dex

The command above will create a new message MsgAddPool with three fields: amount
(in tokens), denom (a string), and active (a boolean). The message will be added
to the "dex" module.

By default, the message is defined as a proto message in the
"proto/{app}/{module}/tx.proto" and registered in the "Msg" service. A CLI command to
create and broadcast a transaction with MsgAddPool is created in the module's
"cli" package. Additionally, Ignite scaffolds a message constructor and the code
to satisfy the sdk.Msg interface and register the message in the module.

Most importantly in the "keeper" package Ignite scaffolds an "AddPool" function.
Inside this function, you can implement message handling logic.

When successfully processed a message can return data. Use the —response flag to
specify response fields and their types. For example

  ignite scaffold message create-post title body --response id:int,title

The command above will scaffold MsgCreatePost which returns both an ID (an
integer) and a title (a string).

Message scaffolding follows the rules as "ignite scaffold list/map/single" and
supports fields with standard and custom types. See "ignite scaffold list —help"
for details.

Usage:
  ignite scaffold message [name] [field1] [field2] ... [flags]

Flags:
      --clear-cache        clear the build cache (advanced)
  -d, --desc string        Description of the command
  -h, --help               help for message
      --module string      Module to add the message into. Default: app's main module
      --no-simulation      Disable CRUD simulation scaffolding
  -p, --path string        path of the app (default ".")
  -r, --response strings   Response fields
      --signer string      Label for the message signer (default: creator)
  -y, --yes                answers interactive yes/no questions with yes

### Query

Query to get data from the blockchain

Usage:
  ignite scaffold query [name] [request_field1] [request_field2] ... [flags]

Flags:
      --clear-cache        clear the build cache (advanced)
  -d, --desc string        Description of the command
  -h, --help               help for query
      --module string      Module to add the query into. Default: app's main module
      --paginated          Define if the request can be paginated
  -p, --path string        path of the app (default ".")
  -r, --response strings   Response fields
  -y, --yes                answers interactive yes/no questions with yes

### Packet (IBC)

Scaffold an IBC packet in a specific IBC-enabled Cosmos SDK module

Usage:
  ignite scaffold packet [packetName] [field1] [field2] ... --module [moduleName] [flags]

Flags:
      --ack strings     Custom acknowledgment type (field1,field2,...)
      --clear-cache     clear the build cache (advanced)
  -h, --help            help for packet
      --module string   IBC Module to add the packet into
      --no-message      Disable send message scaffolding
  -p, --path string     path of the app (default ".")
      --signer string   Label for the message signer (default: creator)
  -y, --yes             answers interactive yes/no questions with yes

### Band (IBC)

Scaffold an IBC BandChain query oracle to request real-time data from BandChain scripts in a specific IBC-enabled Cosmos SDK module

Usage:
  ignite scaffold band [queryName] --module [moduleName] [flags]

Flags:
      --clear-cache     clear the build cache (advanced)
  -h, --help            help for band
      --module string   IBC Module to add the packet into
  -p, --path string     path of the app (default ".")
      --signer string   Label for the message signer (default: creator)
  -y, --yes             answers interactive yes/no questions with yes