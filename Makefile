DL=https://www.sqlite.org/2016/sqlite-amalgamation-3140100.zip

.PHONY: docker-image clean

sqlite.zip:
	wget -O sqlite.zip $(DL)

docker/sqlite3: sqlite.zip
	unzip -n -q sqlite.zip; \
	cd sqlite-amalgamation*; \
	gcc -o ../docker/sqlite3 shell.c sqlite3.c -lpthread -ldl

docker-image: docker/sqlite3
	cd docker; \
		docker build -t kenpu/sqlite3-cli .

clean:
	rm -rf sqlite.zip sqlite-amalgamation* docker/sqlite3
