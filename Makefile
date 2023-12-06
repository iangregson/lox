JAVA_VERSION = 17
JAVAC = javac
JAVA = java

JAVA_COMPILE_OPTIONS = --enable-preview --release $(JAVA_VERSION)
JAVA_OPTIONS = --enable-preview

JAVA_MAIN_CLASS = com.craftinginterpreters.lox.Lox
JAVA_SOURCES = $(wildcard src/main/java/**/**/**/*.java)
JAVA_CLASSES = $(patsubst src/main/java/%.java, target/classes/%.class, $(JAVA_SOURCES))

# Compile the Java source files
compile: $(JAVA_CLASSES)
	$(info Java source files: $(JAVA_SOURCES))
	$(info Java class files: $(JAVA_CLASSES))

# Run the Java main class
run: compile
	$(JAVA) $(JAVA_OPTIONS) -cp target/classes $(JAVA_MAIN_CLASS)

# Clean the target directory
clean:
	rm -rf target

# Compile the Java source files
target/classes/%.class: src/main/java/%.java
	$(JAVAC) $(JAVA_COMPILE_OPTIONS) -d target/classes $<

# Create the target directory
target/classes:
	mkdir -p target/classes

# Make the target directory a dependency of the Java class files
$(JAVA_CLASSES): target/classes
compile: target/classes
clean: target/classes
run: target/classes
default: target/classes

default: run
