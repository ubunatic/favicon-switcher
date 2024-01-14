.PHONY: ⚙️

SOURCES      := $(shell find icons src *.js *.json)
XPI          := $(shell find web-ext-artifacts -name "*.xpi")
FIREFOX_PATH := /Applications/Firefox.app/Contents/MacOS
MOZILLA_USER ?= user:00000000:000
MOZILLA_KEY  ?= get it from https://addons.mozilla.org/en-US/developers/addon/api/key

all: build

web-ext: ⚙️
	brew install web-ext

build: ⚙️
	web-ext build --overwrite-dest

sign: ⚙️
	@web-ext sign \
		--api-key="$(MOZILLA_USER)" \
		--api-secret="$(MOZILLA_KEY)" \
		--use-submission-api \
		--channel=unlisted

install: ⚙️ $(XPI)
	export PATH="$$PATH:$$FIREFOX_PATH" && \
	firefox -url about:addons
	# -------------------
	# Add-on Installation
	# -------------------
	#
	# 1. Click the ⚙️ icon in the "about:addons" page
	#    and select "Install Add-on From File...".
	# 2. Once installed, click the 🧩 icon in the Toolbar
	#    click the ⚙️ icon of the "FaviconSwitcher" Add-on
	#    and finally select "Pin to Toolbar"
	#
