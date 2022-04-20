# Description
Edit for yourself:
- package.json
- /tests/
- /contracts
- /migrations
- /storage

```
./storage - prod storage
./tests/storage - dev storage

```

# Requirements

- Installed NodeJS (tested with NodeJS v14+)
- Installed Yarn

- Installed node modules:

```
yarn install

```

# Quick Start tests (TODO)

```
yarn start-sandbox

```


```
yarn test

``` 

![image](https://user-images.githubusercontent.com/44075582/126524242-6fdd8cf3-a5b5-4143-b46f-97eb7a0a2e73.png)


```
yarn stop-sandbox

```

# Compile contract

```
yarn compile -c router

```

# Compile bytes

Compile parser contract

```sh
yarn compile-parser ${parserName}
```

ex. 

```sh 
yarn compile-parser harbinger
```

Compile and prepare parser bytes

```sh 
yarn parser-to-bytes ${parserName}
```

ex. 
```sh
yarn parser-to-bytes harbinger
```

# Deploy contract

```
yarn migrate

```
