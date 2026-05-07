## ****************************************************************************
## ****************************************************************************
## Copyright SoC Design Research Group, All rights reserved.    
## Electronics and Telecommunications Research Institute (ETRI)
##
## THESE DOCUMENTS CONTAIN CONFIDENTIAL INFORMATION AND KNOWLEDGE 
## WHICH IS THE PROPERTY OF ETRI. NO PART OF THIS PUBLICATION IS 
## TO BE USED FOR ANY OTHER PURPOSE, AND THESE ARE NOT TO BE 
## REPRODUCED, COPIED, DISCLOSED, TRANSMITTED, STORED IN A RETRIEVAL 
## SYSTEM OR TRANSLATED INTO ANY OTHER HUMAN OR COMPUTER LANGUAGE, 
## IN ANY FORM, BY ANY MEANS, IN WHOLE OR IN PART, WITHOUT THE 
## COMPLETE PRIOR WRITTEN PERMISSION OF ETRI.
## ****************************************************************************
## 2022-10-12
## Kyuseung Han (han@etri.re.kr)
## ****************************************************************************
## ****************************************************************************

ifdef RVX_MINI_HOME
	include ${RVX_MINI_HOME}/rvx_config.mh
else
	include ${RVX_DEVKIT_HOME}/rvx_config.mh
endif

TEMPLATE_FILE = ${RVX_ENV}/makefile/Makefile.util.template
include ${RVX_UTIL_HOME}/template_makefile.mh

UTIL_LIST=mmio rom image fakefile npx arx

$(addsuffix .base, ${UTIL_LIST}):%.base:
	@if [ ! -d $(*) ]; \
	then \
		mkdir $(*); \
	fi
	@${PYTHON3_CMD} ${RVX_UTIL_HOME}/configure_template.py -i ${RVX_ENV}/util/Makefile.$(*).template -o ${CURDIR}/$(*)/Makefile
	@if [ -f ${RVX_ENV}/util/gitignore.$(*).txt ]; \
	then \
		cp -f ${RVX_ENV}/util/gitignore.$(*).txt ${CURDIR}/$(*)/.gitignore; \
	fi

${UTIL_LIST}:%: FORCE %.base

clean: $(addsuffix .clean, ${UTIL_LIST})

$(addsuffix .clean, ${UTIL_LIST}):%.clean:
	@if [ -d $(*) ]; \
	then \
		cd $(*) && make --no-print-directory clean; \
	fi

-include ./user_util.mh

FORCE:

.PHONY: FORCE clean
