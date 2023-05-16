# GWF Chain

[Home](../README.md) | [GWF Chain](./gwf.md) | [Profiles](./profile.md) | [Blogger](./blog.md) | [Squares](./sqrz.md) | [Fund Me](./fund.md)

## Overview

This project is has been created and will be developed by Nlaak Studios, LLC a Texas-based S-Corp. Currently, the online sites are traditional sites with licensed code and so are private repositories. However, the project, when finished will be 100% decentralized and governed by the community.

With the migration of the current traditional centralized sites to off-shore dedicated servers that are secure and provide favourable data security laws complete, we have only left GWF.IO (Social) and Media-Junky.com (Video Sharing) online at this time. The others will be available again when we release the new Decentralized Platform, including the complete re-write of GWF Social and Media Junky.

Once the Core Development team is in place we will get the Official Whitepaper and Road map released.

## About Us

### Tagline

Your Social Platform, Your Way! We are the unified decentralized social platform for all!

### Mission

To provide a secure social media platform able to serve any content distributor while ensuring Privacy, user control.

### Vision

To build a system of social networking that gives users Privacy, Security, and Freedom on their legal content distribution.

### Summary

GWF is a unified decentralized social media platform that allows you to be responsible for your content.
Global wealth and Freedom platform allow for all types of content Social Networking, Video Sharing, and Instant Messaging with Audio & Video calls, Micro-Blogging, Blogging, DEX, and much more.

GWF is a no censoring, no tracking, and no ads platform where you have complete control of your online presence, content, security, and Privacy.
You will love the GWF platform as it doesn't use cookies – otherwise known as trackers- to generate revenue; hence you can be confident that we do not sell your content to advertisers. The platform also allows for ultimate freedom of expression as there is no censoring, thus enabling you to take control and push your content. 

We believe users can think for themselves and hence be able to decide what they want to consume. Therefore, the ultimate goal is not for us to "Define" the platform - but rather to listen to our user's feedback and suggestions and build the social platform for the future.
With GWF, you can say goodbye to big tech with all their tracking, ads, and censoring and say Hello to your personalized social network where you have full control of your online presence, content, security, and Privacy.

However, this system is not intended for "Drug Lords," "Arms Dealers," and "Developers of Mass Destruction." It's intended to protect the rights and privacy of law-abiding everyday end users. We must also still abide by the "Know Your Customer" (KYC) and "Anti Money Laundering" (AML) laws as set forth and must be honoured in most countries on the planet.

Best of all ... It's all one a single App and uniform across all platforms. Leave off on your desktop and pick up on the go with your mobile. It's all seamless.

### Core Values

#### Privacy

Keep your content within the locus of your control. With our no ads policy, your data is not sold to advertisers as an income generation scheme. We will strive to implement every feature known to protect the identity of the users of this token. Strong encryption. No one should be aware that you are using this system unless you somehow make them aware of it.

#### Security

As with Privacy, we will strive to implement the most robust security features, but with emphasis on not hindering the end, users' use of the system. There will be many layers of security that you can turn on or off when desired.

#### Performance

With the Front-end primary app created with Flutter, it allows for a single code base for developers (Web, iOS, Android, Windows, Mac, and Linux) and a standardized and easy-to-use interface for the users.

#### Versatility

As long as your content remains to be legal, we don't practice censorship. It is our firm belief that anyone who uses our platform is able to choose for themselves what they want to consume.

#### Sustainability

We are using the absolute latest in technology to create the only 100% decentralized & Self-Sustaining Social Platform for the future.

## Modules

| Priority | Module | Description                                                | Link                   | Dependencies | Status      |
| -------- | ------ | ---------------------------------------------------------- | ---------------------- | ------------ | ----------- |
| 1        | prof   | Implements users profile page, Settings & Security         | [profile](./prof.md)   | account      | Not Started |
| 2        | blog   | Allows users to enable & use the Blogger feature           | [blog](./blog.md)      | account,bank | Scaffolded  |
| 3        | sqrz   | Allows users to enable & use the Squares feature           | [sqrz](./sqrz.md)      | account,bank | Scaffolded  |
| 4        | fund   | Allows users to enable & use the Fund Me feature           | [fund](./fund.md)      | account,bank | Design      |
| 5        | imsg   | Allows users to enable & use the Instant Messaging feature | [imsg](./imsg.md)      | account      | Not Started |
| 6        | chat   | Allows users to enable & use the Chat feature              | [chat](./chat.md)      | account      | Not Started |
| 7        | ctcs   | Allows users to enable & use the Contacts feature          | [ctcs](./ctcs.md)      | account      | Not Started |
| 8        | evnt   | Allows users to enable & use the Event feature             | [event](./evnt.md)     | account      | Not Started |
| 9        | stor   | Allows users to enable & use the Store feature             | [store](./stor.md)     | account,bank | Not Started |
| 10       | nft    | Allows users to enable & use the NFT feature               | [nft](./nft.md)        | account,bank | Not Started |
| 11       | vote   | Allows users to enable & use the Voting feature            | [vote](./vote.md)      | account,vote | Not Started |
| 12       | mrkt   | Allows users to enable & use the Market feature            | [market](./mrkt.md)    | account,bank | Not Started |
| 13       | dona   | Allows users to enable & use the Donate feature            | [donate](./dona.md)    | account,bank | Not Started |
| 14       | auct   | Allows users to enable & use the Auction feature           | [auction](./auct.md)   | account,bank | Not Started |
| 15       | rffl   | Allows users to enable & use the Raffle feature            | [raffle](./rffl.md)    | account,bank | Not Started |
| 16       | ltry   | Allows users to enable & use the Lottery feature           | [lottery](./ltry.md)   | account,bank | Not Started |
| 17       | ask    | Allows users to enable & use the Ask feature (chatAI)      | [find](./ask.md)       | account      | Not Started |
| 18       | loan   | Allows users to enable & use the Loan feature              | [loan](./loan.md)      | account,bank | Not Started |
| 19       | stke   | Allows users to enable & use the Stake feature             | [stake](./stke.md)     | account,bank | Not Started |
| 20       | defi   | Allows users to enable & use the DeFi feature              | [defi](./defi.md)      | account,bank | Not Started |
| 21       | gov    | Allows users to enable & use the Governance feature        | [governance](./gov.md) | account,bank | Not Started |

> Status: Not Started, Scaffolded, Design, In Progress, Complete

## Ignite Scaffold

```sh

```sh
ignite scaffold chain gwf --address-prefix gwf
```

```sh
Cosmos SDK's version is: stargate - v0.46.6

🛠  Building proto...
📦 Installing dependencies...
🛠  Building the blockchain...
💿 Initializing the app...
🗂  Initialize accounts...
🙂 Added account alice with address gwf1zjutxkvyz22v73mrjwq0eky0p5c0yvahfe66me and mnemonic: flip antique slow lunar glow spoil gas gloom rotate antenna pair garden wire usage spring awkward primary museum denial renew taste sauce report virus
🙂 Added account bob with address gwf1dsnlcy76pslkuwqd2g7973y377kw53gx8nt4pq and mnemonic: save you farm vocal goose alcohol master hidden goddess ride yellow nuclear else napkin horror spoil ring regular poverty cigar valid alpha reveal current
🌍 Tendermint node: http://0.0.0.0:26657
🌍 Blockchain API: http://0.0.0.0:1317
🌍 Token faucet: http://0.0.0.0:4500
```

## Helpful Linux Commands

### Kill a process on a port

```sh
sudo kill -9 $(sudo lsof -t -i:26657) # Tendermint Node
sudo kill -9 $(sudo lsof -t -i:1317) # Blockchain API
sudo kill -9 $(sudo lsof -t -i:4500) # Token faucet
```