 #!/bin/bash

#preparations

echo '\x1b[31;1mType in NAME variable\x1b[0m'
read name
echo '\x1b[31;1mWhat will it build?
1. Executable
2. Library
3. Else\x1b[0m'
read comp_type
exec > Makefile

#create header

echo "# **************************************************************************** #" 
echo "#                                                                              #"
echo "#                                                         :::      ::::::::    #"
echo "#    Makefile                                           :+:      :+:    :+:    #"
echo "#                                                     +:+ +:+         +:+      #"

printf "#    By: "
printf "%8s" $USER
printf " <"
printf "%8s" $USER
echo "@student.unit.ua>        +#+  +:+       +#+         #"

echo "#                                                 +#+#+#+#+#+   +#+            #"

printf "#    Created: "
date +"%Y/%m/%d %H:%M:%S" | tr -d '\n'

printf " by "
printf "%8s" $USER
echo "          #+#    #+#              #"

printf "#    Updated: "
date +"%Y/%m/%d %H:%M:%S" | tr -d '\n'
printf " by "
printf "%8s" $USER
echo "         ###   ########.fr        #"
echo "#                                                                              #"
echo "# **************************************************************************** #"

#Makefile start

printf "
NAME = "

echo $name

printf "
INCDIR = includes/

SRC = "

#src initialization

ls | find . -name "*.c" -maxdepth 1 | cut -c 3- | tr '\n' ' '

#Makefile pattern

echo "

OBJDIR = objects

OBJ = \$(addprefix \$(OBJDIR)/, \$(SRC:.c=.o))

LIB = libft/libft.a

INCDIR = includes

FLAGS = -Wall -Werror -Wextra

.PHONY: all clean fclean re cleanlib fcleanlib relib

all: \$(NAME)

\$(NAME): \$(OBJ) \$(LIB)"

case $comp_type in
	1) echo "	gcc \$(FLAGS) \$(OBJ) \$(LIB) -o \$(NAME)";;
 	2) echo "	ar -rcs \$(NAME) \$(OBJ) \$(LIB)";;
 	*) echo "	!Write your compilation instructions here!";;
esac

echo "
\$(LIB):
	make -C libft all
	
\$(OBJDIR)/%.o: ./%.c \$(INCDIR)/*.h | \$(OBJDIR)
	gcc \$(FLAGS) -o \$@ -c \$< -I \$(INCDIR)

\$(OBJDIR):
	mkdir \$(OBJDIR)

clean:
	rm -Rf \$(OBJDIR)

fclean: clean
	rm -f \$(NAME)

re: fclean all

cleanlib:
	make -C libft clean

fcleanlib:
	make -C libft fclean

relib:
	make -C libft re"
