package de.unikassel.vs.alica.codegen.cpp.templates;

import de.unikassel.vs.alica.planDesigner.alicamodel.Behaviour;
import de.unikassel.vs.alica.codegen.templates.IBehaviourTemplates;
import org.apache.commons.lang3.StringUtils;


class BehaviourTemplatesSource implements IBehaviourTemplates {

    override String behaviour(Behaviour behaviour) '''
«IF (behaviour.relativeDirectory.isEmpty)»
    #include "«StringUtils.capitalize(behaviour.name)».h"
«ELSE»
    #include "«behaviour.relativeDirectory»/«StringUtils.capitalize(behaviour.name)».h"
«ENDIF»
#include "DomainBehaviour.h"
#include "«StringUtils.capitalize(behaviour.name)»Impl.h"
#include <memory>

namespace alica {
    «StringUtils.capitalize(behaviour.name)»::«StringUtils.capitalize(behaviour.name)»(void* context): DomainBehaviour("«behaviour.name»", «behaviour.id», context) {
        this.impl = std::make_shared<«StringUtils.capitalize(behaviour.name)»Impl>(this);
    }

    void «StringUtils.capitalize(behaviour.name)»::run(void* msg) {
        this.impl.run(msg);
    }

    void «StringUtils.capitalize(behaviour.name)»::initialiseParameters() {
        this.impl.initialiseParameters();
    }
}
'''

    override String behaviourImpl(Behaviour behaviour) '''
#include "DomainBehaviour.h"
#include "DomainBehaviourImpl.h"

namespace alica {
    «StringUtils.capitalize(behaviour.name)»Impl::«StringUtils.capitalize(behaviour.name)»Impl(DomainBehaviour domain): DomainBehaviour(domain) {

    }

    void «StringUtils.capitalize(behaviour.name)»Impl::run(void* msg) {
        std::cout << "Behaviour «StringUtils.capitalize(behaviour.name)»(" << this.domain.getOwnId() << "): started" << std::endl;
    }

    void «StringUtils.capitalize(behaviour.name)»Impl::initialiseParameters() {

    }
}
'''

    override String behaviourCondition(Behaviour behaviour) '''
«IF (behaviour.relativeDirectory.isEmpty)»
    #include "«StringUtils.capitalize(behaviour.name)»«behaviour.id».h"
«ELSE»
    #include "«behaviour.relativeDirectory»/«StringUtils.capitalize(behaviour.name)»«behaviour.id».h"
«ENDIF»
#include <memory>

namespace alica {
    «StringUtils.capitalize(behaviour.name)»«behaviour.id»::id = «behaviour.id»;
}
'''

    override String preConditionBehaviour(Behaviour behaviour) '''
namespace alicaAutogenerated {
    PreCondition«behaviour.preCondition.id»::id = «behaviour.preCondition.id»;

    PreCondition«behaviour.preCondition.id»::PreCondition«behaviour.preCondition.id»(void* context): DomainCondition(context) {
        this.impl = std::make_shared<PreCondition«behaviour.preCondition.id»Impl>();
    }

    bool PreCondition«behaviour.preCondition.id»::evaluate(std::shared_ptr<RunningPlan> rp) {
        this.impl.evaluate(rp);
    }
}
'''

    override String preConditionBehaviourImpl(Behaviour behaviour) '''
namespace alicaAutogenerated {
    PreCondition«behaviour.preCondition.id»Impl::id = «behaviour.preCondition.id»;

    PreCondition«behaviour.preCondition.id»Impl::PreCondition«behaviour.preCondition.id»Impl() {

    }

    bool PreCondition«behaviour.preCondition.id»Impl::evaluate(std::shared_ptr<RunningPlan> rp) {
        std::cerr << "The PreCondition " << this.id << " is not implement yet!" << std::endl;
        return false;
    }
}
'''

    override String runtimeConditionBehaviour(Behaviour behaviour) '''
namespace alicaAutogenerated {
    RunTimeCondition«behaviour.runtimeCondition.id»::id = «behaviour.runtimeCondition.id»;

    RunTimeCondition«behaviour.runtimeCondition.id»::RunTimeCondition«behaviour.runtimeCondition.id»(void* context): DomainCondition(context) {
        this.impl = std::make_shared<RunTimeCondition«behaviour.runtimeCondition.id»Impl>();
    }

    bool RunTimeCondition«behaviour.runtimeCondition.id»::evaluate(std::shared_ptr<RunningPlan> rp) {
        return this.impl.evaluate(rp);
    }
}
'''

    override String runtimeConditionBehaviourImpl(Behaviour behaviour) '''
namespace alicaAutogenerated {
    RunTimeCondition«behaviour.runtimeCondition.id»Impl::id = «behaviour.runtimeCondition.id»;

    RunTimeCondition«behaviour.runtimeCondition.id»Impl::RunTimeCondition«behaviour.runtimeCondition.id»Impl() {

    }

    bool RunTimeCondition«behaviour.runtimeCondition.id»Impl::evaluate(std::shared_ptr<RunningPlan> rp) {
        std::cerr << "The RunTimeCondition " << id << " is not implement yet!" << std::endl;
        return false;
    }
}
'''

    override String postConditionBehaviour(Behaviour behaviour) '''
namespace alicaAutogenerated {
    PostCondition«behaviour.postCondition.id»::id = «behaviour.postCondition.id»;

    PostCondition«behaviour.postCondition.id»::PostCondition«behaviour.postCondition.id»(void* context): DomainCondition(context) {
        this.impl = std::make_shared<PostCondition«behaviour.postCondition.id»Impl>();
    }

    bool PostCondition«behaviour.postCondition.id»::evaluate(std::shared_ptr<RunningPlan> rp) {
        return this.impl.evaluate(rp);
    }
}
'''

    override String postConditionBehaviourImpl(Behaviour behaviour) '''
namespace alicaAutogenerated {
    PostCondition«behaviour.postCondition.id»Impl::id = «behaviour.postCondition.id»;

    PostCondition«behaviour.postCondition.id»Impl::PostCondition«behaviour.postCondition.id»Impl() {

    }

    bool PostCondition«behaviour.postCondition.id»Impl::evaluate(std::shared_ptr<RunningPlan> rp) {
        std::cerr << "The PostCondition " << id << " is not implement yet!" << std::endl;
        return false;
    }
}
'''

    override String constraints(Behaviour behaviour) '''
«IF (behaviour.relativeDirectory.isEmpty)»
    #include "constraints/«StringUtils.capitalize(behaviour.name)»«behaviour.id»Constraints.h"
«ELSE»
    #include "«behaviour.relativeDirectory»/constraints/«StringUtils.capitalize(behaviour.name)»«behaviour.id»Constraints.h"
«ENDIF»

namespace alicaAutogenerated {
    «StringUtils.capitalize(behaviour.name)»«behaviour.id»Constraints::id = «behaviour.id»;
}
'''

    override String constraintPreCondition(Behaviour behaviour) '''
namespace alicaAutogenerated {
    Constraint«behaviour.preCondition.id»::id = «behaviour.preCondition.id»;

    Constraint«behaviour.preCondition.id»::Constraint«behaviour.preCondition.id»() {
        this.impl = std::make_shared<Constraint«behaviour.preCondition.id»Impl>();
    }

    void Constraint«behaviour.preCondition.id»::getConstraint(std::shared_ptr<ProblemDescriptor> c, std::shared_ptr<RunningPlan> rp) {
        this.impl.getConstraint(c, rp);
    }
}
'''

    override String constraintPreConditionImpl(Behaviour behaviour) '''
namespace alicaAutogenerated {
    Constraint«behaviour.preCondition.id»Impl::id = «behaviour.preCondition.id»;

    Constraint«behaviour.preCondition.id»Impl::Constraint«behaviour.preCondition.id»Impl() {

    }

    void Constraint«behaviour.preCondition.id»Impl::getConstraint(std::shared_ptr<ProblemDescriptor> c, std::shared_ptr<RunningPlan> rp) {

    }
}
'''

    override String constraintRuntimeCondition(Behaviour behaviour) '''
namespace alicaAutogenerated {
    Constraint«behaviour.runtimeCondition.id»::id = «behaviour.runtimeCondition.id»;

    Constraint«behaviour.runtimeCondition.id»::Constraint«behaviour.preCondition.id»() {
        this.impl = std::make_shared<Constraint«behaviour.runtimeCondition.id»Impl>();
    }

    void Constraint«behaviour.runtimeCondition.id»::getConstraint(std::shared_ptr<ProblemDescriptor> c, std::shared_ptr<RunningPlan> rp) {
        this.impl.getConstraint(c, rp);
    }
}
'''

    override String constraintRuntimeConditionImpl(Behaviour behaviour) '''
namespace alicaAutogenerated {
    Constraint«behaviour.runtimeCondition.id»Impl::id = «behaviour.runtimeCondition.id»;

    Constraint«behaviour.runtimeCondition.id»Impl::Constraint«behaviour.runtimeCondition.id»Impl() {

    }

    void Constraint«behaviour.runtimeCondition.id»Impl::getConstraint(std::shared_ptr<ProblemDescriptor> c, std::shared_ptr<RunningPlan> rp) {

    }
}
'''

    override String constraintPostCondition(Behaviour behaviour) '''
namespace alicaAutogenerated {
    Constraint«behaviour.postCondition.id»::id = «behaviour.postCondition.id»;

    Constraint«behaviour.postCondition.id»::Constraint«behaviour.preCondition.id»() {
        this.impl = std::make_shared<Constraint«behaviour.postCondition.id»Impl>();
    }

    void Constraint«behaviour.postCondition.id»::getConstraint(std::shared_ptr<ProblemDescriptor> c, std::shared_ptr<RunningPlan> rp) {
        this.impl.getConstraint(c, rp);
    }
}
'''

    override String constraintPostConditionImpl(Behaviour behaviour) '''
namespace alicaAutogenerated {
    Constraint«behaviour.postCondition.id»Impl::id = «behaviour.postCondition.id»;

    Constraint«behaviour.postCondition.id»Impl::Constraint«behaviour.postCondition.id»Impl() {

    }

    void Constraint«behaviour.postCondition.id»Impl::getConstraint(std::shared_ptr<ProblemDescriptor> c, std::shared_ptr<RunningPlan> rp) {

    }
}
'''

}
