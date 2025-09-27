---
allowed-tools: [Read, Write, Grep, Glob, TodoWrite]
description: Creates a concise engineering implementation plan based on user requirements and saves it to specs directory
argument-hint: "[requirement-description]"
model: claude-opus-4-1-20250805
---

# Quick Engineering Plan Generator

Generate a concise, actionable engineering implementation plan based on user requirements and save it to the specs directory for future reference.

## Purpose
Create structured implementation plans that serve as blueprints for development tasks, providing clear technical specifications, architecture decisions, and implementation steps.

## Variables
- SPEC_FOLDER: `docs/specs`

## Relevant Files
- @CLAUDE.md

## Workflow

### 1. Requirement Analysis
- Parse user's requirement description
- Extract key technical components and features
- Identify constraints and dependencies
- Determine project scope and boundaries

### 2. Context Discovery
- Search existing codebase for related implementations
- Identify reusable components or patterns
- Note potential conflicts or integration points
- Review project conventions and standards

### 3. Plan Generation
Generate a structured plan containing:

#### Technical Specification
- **Objective**: Clear statement of what needs to be built
- **Scope**: What's included and explicitly excluded
- **Success Criteria**: Measurable outcomes

#### Architecture Overview
- **Components**: List of main components/modules
- **Data Flow**: How data moves through the system
- **Dependencies**: External and internal dependencies
- **Technology Stack**: Specific technologies to use

#### Implementation Steps
1. **Setup Phase**
   - Environment preparation
   - Dependency installation
   - Configuration requirements

2. **Core Development**
   - Step-by-step implementation tasks
   - Order of operations
   - Critical path items

3. **Testing Strategy**
   - Unit test requirements
   - Integration test scenarios
   - Acceptance criteria validation

4. **Deployment Considerations**
   - Migration requirements
   - Configuration changes
   - Rollback strategy

#### Risk Assessment
- **Technical Risks**: Potential technical challenges
- **Mitigation Strategies**: How to handle risks
- **Alternative Approaches**: Backup plans if primary approach fails

#### Timeline Estimate
- **Phase Breakdown**: Time per major phase
- **Dependencies**: Tasks that block others
- **Total Estimate**: Overall implementation time

### 4. File Creation
- Generate filename: `SPEC_FOLDER/[timestamp]_[project-name]_plan.md`
- Create specs directory if it doesn't exist
- Write the plan in markdown format
- Include metadata (date, author, version)

### 5. Plan Validation
- Ensure all sections are complete
- Check for technical consistency
- Verify against project standards
- Add to TodoWrite for tracking

## Report Format

```markdown
# Implementation Plan: [Project Name]

## Metadata
- **Created**: [Timestamp]
- **Type**: Engineering Implementation Plan
- **Status**: Draft

## Executive Summary
[1-2 sentence overview]

## Technical Specification
### Objective
[Clear goal statement]

### Scope
**Included:**
- [Items in scope]

**Excluded:**
- [Items out of scope]

### Success Criteria
- [ ] [Measurable outcome 1]
- [ ] [Measurable outcome 2]

## Architecture
### Components
- **[Component Name]**: [Purpose and responsibility]

### Data Flow
[Description or simple diagram]

### Dependencies
- [External dependencies]
- [Internal dependencies]

## Implementation Steps

### Phase 1: Setup
- [ ] [Task 1]
- [ ] [Task 2]

### Phase 2: Core Development
- [ ] [Task 1]
- [ ] [Task 2]

### Phase 3: Testing
- [ ] [Unit tests]
- [ ] [Integration tests]

### Phase 4: Deployment
- [ ] [Deployment tasks]

## Risk Assessment
| Risk | Impact | Mitigation |
|------|--------|------------|
| [Risk 1] | [High/Medium/Low] | [Strategy] |

## Timeline
- **Phase 1**: [Duration]
- **Phase 2**: [Duration]
- **Total**: [Total estimate]

## Notes
[Additional considerations]
```

## Output
- Save plan to `SPEC_FOLDER/[timestamp]_[project-name]_plan.md`
- Display confirmation with file path
- Show executive summary
- Add implementation tasks to TodoWrite
- Suggest next steps (review, refinement, implementation start)

## Examples

### Basic Usage
```
/quick-plan "Add user authentication with JWT tokens and refresh mechanism"
```

### Complex Feature
```
/quick-plan "Implement real-time notification system with WebSocket support, message queuing, and delivery tracking"
```

## Best Practices
- Keep plans concise but comprehensive
- Focus on actionable items
- Include clear success criteria
- Consider edge cases and error handling
- Document assumptions explicitly
- Version plans for tracking changes
- Reference existing patterns in codebase
