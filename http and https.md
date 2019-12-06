##https and http

###这两种协议都是用于在Web服务器和Web浏览器之间交换特定网站的信息的协议.

----
####Http = HyperText Transfer Protocol 

HTTP is a protocol using which hypertext is transferred over the Web. Due to its simplicity, http has been the most widely used protocol for data transfer over the Web but the data (i.e. hypertext) exchanged using http isn’t as secure as we would like it to be. In fact, hyper-text exchanged using http goes as plain text i.e. anyone between the browser and server can read it relatively easy if one intercepts this exchange of data. But why do we need this security over the Web. Think of ‘Online shopping’ at Amazon or Flipkart. You might have noticed that as soon as we click on the Check-out on these online shopping portals, the address bar gets changed to use https. This is done so that the subsequent data transfer (i.e. financial transaction etc.) is made secure. And that’s why https was introduced so that a secure session is setup first between Server and Browser.


In fact, cryptographic protocols such as SSL and/or TLS turn http into https i.e. https = http + cryptographic protocols. Also, to achieve this security in https, Public Key Infrastructure (PKI) is used because public keys can be used by several Web Browsers while private key can be used by the Web Server of that particular website. The distribution of these public keys is done via Certificates which are maintained by the Browser. You can check these certificates in your Browser settings. 

----

HTTP是一种协议，使用该协议通过Web传输超文本。由于其简单性，http是使用最广泛的Web数据传输协议，但是使用http交换的数据（即超文本）并不安全。事实上，使用http交换的超文本作为纯文本进行，即如果拦截这种数据交换，浏览器和服务器之间的任何人都可以相对容易地读取它。但是为什么我们需要通过Web获得这种安全性。想想亚马逊的'在线购物'，只要我们点击这些在线购物门户网站上的“结账”，地址栏就会更改为使用https。这样做是为了使随后的数据传输（即金融交易等）安全。这就是为什么引入https以便首先在服务器和浏览器之间设置安全会话的原因。

实际上，诸如SSL和/或TLS之类的加密协议将http转换为https，即 https = http + cryptographic protocols 。此外，为了在https中实现此安全性，使用公钥基础结构 Public Key Infrastructure（PKI），因为公钥可以由多个Web浏览器使用，而私钥可以由该特定网站的Web服务器使用。这些公钥的分发是通过浏览器维护的证书完成的。您可以在浏览器设置中查看这些证书。

----

与HTTP连接相比，HTTPS有一些缺点。但是，这些很少，应该被接受为它提供的安全性的妥协。
- 随着流量的增加，证书会产生额外费用并增加成本。这些可能特别高。特别是对于新旧网站，这些费用可能会相对较高。
- 使用HTTPS连接时，无法缓存内容。但是，更高带宽的趋势抵消了这种劣势。
- 使用SSL加密导致的较差性能。服务器必须执行更多计算，从而增加响应时间。
- 虚拟主机不支持HTTPS。